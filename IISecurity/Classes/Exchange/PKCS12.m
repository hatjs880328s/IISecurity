//
//  PKCS12.m
//  EWS-For-iOS
//
//  Created by Noah_Shan on 2018/12/5.
//  Copyright © 2018 wangxk. All rights reserved.
//

#import "PKCS12.h"
#import <CommonCrypto/CommonDigest.h>

#import <CommonCrypto/CommonCryptor.h>

#import <Security/Security.h>
#import "x509.h"

//#import "NSData+Base64.h"
#define kChosenDigestLength CC_SHA1_DIGEST_LENGTH  // SHA-1消息摘要的数据位数160位

@implementation PKCS12


/*
 如何使用：
 1.入参datas是pfx文件的数据流
 NSData *fileData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:cloudFile.fileRealPath]];
 PKCS12 *pkc = [[PKCS12 alloc] init];
 [pkc decrypt:fileData];

 2.补码方式
 现在使用的是： kSecPaddingPKCS1

 3.
 RSA加密&解密
 pfx文件私钥 & 公钥 的获取
 SecKeyRef公钥转为nsdata的方法

 参考：
 https://www.jianshu.com/p/3e019981c118
 */


-(NSString *)decrypt:(NSData *)datas {
    NSString *firstMing = @"hehefdsdfdsa";
    SecKeyRef publickey = [self getPublicKey:datas pwd:@"shanwzh"];
    NSString *fristMi = [self rsaEncryptString:firstMing pubKey:publickey];
    SecKeyRef privatekey = [self loadPrivateKeyFromData:datas password:@"shanwzh"];
    NSString *ming = [self rsaDecryptString:fristMi privateKey:privatekey];
    CFRelease(publickey);
    CFRelease(privatekey);
    return ming;
}

/// 私钥加签
-(NSString *)signTheDataSHA1WithRSA:(NSString *)plainText pfxFiledatas:(NSData *)datas
{
    uint8_t* signedBytes = NULL;
    size_t signedBytesSize = 0;
    OSStatus sanityCheck = noErr;
    NSData* signedHash = nil;
    NSData * data = datas;
    //因为pfx之前设置的有密码所以这里要设置一下
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init]; // Set the private key query dictionary.
    [options setObject:@"shanwzh" forKey:(id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((CFDataRef) data, (CFDictionaryRef)options, &items);
    if (securityError!=noErr) {
        return nil ;
    }
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityApp =(SecIdentityRef)CFDictionaryGetValue(identityDict,kSecImportItemIdentity);
    SecKeyRef privateKeyRef=nil;
    SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    signedBytesSize = SecKeyGetBlockSize(privateKeyRef);

    NSData *plainTextBytes = [plainText dataUsingEncoding:NSUTF8StringEncoding];

    signedBytes = malloc( signedBytesSize * sizeof(uint8_t) ); // Malloc a buffer to hold signature.
    memset((void *)signedBytes, 0x0, signedBytesSize);
    sanityCheck = SecKeyRawSign(privateKeyRef,
                                kSecPaddingPKCS1,
                                (const uint8_t *)[[self getHashBytes:plainTextBytes] bytes],
                                CC_SHA1_DIGEST_LENGTH,
                                (uint8_t *)signedBytes,
                                &signedBytesSize);
    if (sanityCheck == noErr)
    {
        signedHash = [NSData dataWithBytes:(const void *)signedBytes length:(NSUInteger)signedBytesSize];
    }
    else
    {
        return nil;
    }

    if (signedBytes)
    {
        free(signedBytes);
    }
    NSString *signatureResult=[signedHash base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return signatureResult;
}

/// 工具方法
- (NSData *)getHashBytes:(NSData *)plainText {
    CC_SHA1_CTX ctx;
    uint8_t * hashBytes = NULL;
    NSData * hash = nil;
    // Malloc a buffer to hold hash.
    hashBytes = malloc( CC_SHA1_DIGEST_LENGTH * sizeof(uint8_t) );
    memset((void *)hashBytes, 0x0, kChosenDigestLength);
    // Initialize the context.
    CC_SHA1_Init(&ctx);
    // Perform the hash.
    CC_SHA1_Update(&ctx, (void *)[plainText bytes], (unsigned int)[plainText length]);
    // Finalize the output.
    CC_SHA1_Final(hashBytes, &ctx);
    // Build up the SHA1 blob.
    hash = [NSData dataWithBytes:(const void *)hashBytes length:(NSUInteger)kChosenDigestLength];
    if (hashBytes) free(hashBytes);

    return hash;
}

/// 获取公钥A
- (SecKeyRef)getPublicKey: (NSData *)pfxData pwd:(NSString *)passwords{
    NSData * data = pfxData;
    SecIdentityRef myIdentity;
    SecTrustRef myTrust;
    //extractIdentityAndTrust((__bridge CFDataRef)data, &myIdentity, &myTrust);

    /// 获取公钥B
    OSStatus securityError = errSecSuccess;
    NSString *strss = passwords;
    CFStringRef password = (__bridge CFStringRef)strss;//CFSTR("shanwzh");
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)data, options, &items);
    CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
    const void *tempIdentity = NULL;
    tempIdentity = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
    myIdentity = (SecIdentityRef)tempIdentity;
    const void *tempTrust = NULL;
    tempTrust = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
    myTrust = (SecTrustRef)tempTrust;
    if (options) {
        CFRelease(options);
    }


    SecKeyRef publicKey;
    publicKey = SecTrustCopyPublicKey(myTrust);
    return publicKey;
}

/// 获取公钥B
//OSStatus extractIdentityAndTrust(CFDataRef inP12data, SecIdentityRef *identity, SecTrustRef *trust)
//{
//    OSStatus securityError = errSecSuccess;
//    NSString *strss = @"shanwzh";
//    CFStringRef password = (__bridge CFStringRef)strss;//CFSTR("shanwzh");
//    const void *keys[] = { kSecImportExportPassphrase };
//    const void *values[] = { password };
//    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
//    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
//    securityError = SecPKCS12Import(inP12data, options, &items);
//    if (securityError == 0) {
//        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items, 0);
//        const void *tempIdentity = NULL;
//        tempIdentity = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemIdentity);
//        *identity = (SecIdentityRef)tempIdentity;
//        const void *tempTrust = NULL;
//        tempTrust = CFDictionaryGetValue(myIdentityAndTrust, kSecImportItemTrust);
//        *trust = (SecTrustRef)tempTrust;
//    }
//    if (options) {
//        CFRelease(options);
//    }
//    return securityError;
//}

///获取私钥A
- (SecKeyRef)loadPrivateKeyFromData:(NSData*)p12Data password:(NSString*)p12Password {
    SecKeyRef privateKey = [self getPrivateKeyRefrenceFromData:p12Data password:p12Password];
    return privateKey;
}

///获取私钥B
- (SecKeyRef)getPrivateKeyRefrenceFromData:(NSData*)p12Data password:(NSString*)password {
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }else{
        privateKeyRef = NULL;
    }
    CFRelease(items);

    return privateKeyRef;
}

/// 根据p12文件获取cer对象之后，获取证书的相关信息-包含过期时间&颁发者&接受者
- (NSDictionary *)getCERFileDetailInfos: (NSData *)p12Data password: (NSString *)password {
    NSDictionary *result = NULL;
    NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
    [options setObject: password forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        SecCertificateRef certificate = NULL;
        securityError = SecIdentityCopyCertificate(identityApp, &certificate);
        if (securityError != noErr) {
            result = NULL;
        } else {
            NSData *certificateData = (NSData *) CFBridgingRelease(SecCertificateCopyData(certificate));
            const unsigned char *certificateDataBytes = (const unsigned char *)[certificateData bytes];
            X509 *certificateX509 = d2i_X509(NULL, &certificateDataBytes, [certificateData length]);
            NSDate *expiryDate = CertificateGetExpiryDate(certificateX509);
            NSString *poster = CertificateGetISSUer(certificateX509);
            NSString *owner = CertificateGetOwner(certificateX509);
            result = @{@"EXPIRYDATE": expiryDate, @"POSTER": poster, @"OWNER": owner};
            return result;
        }
    }else{
        result = NULL;
    }
    CFRelease(items);

    return result;
}



/// RSA解密
- (NSString *)rsaDecryptString:(NSString*)string privateKey:(SecKeyRef) privatekeys {

    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *decryptData = [self rsaDecryptData:data privateKey:privatekeys];
    NSString *result = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSData*)rsaDecryptData:(NSData*)data privateKey:(SecKeyRef) privatekeys {
    SecKeyRef key = privatekeys;
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);

    if (status != noErr) {
        return nil;
    }
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    return decryptedData;
}

/// 加密
- (NSString *)rsaEncryptString:(NSString *)string pubKey:(SecKeyRef)pubkeys {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [self rsaEncryptData:data publicKey:pubkeys];
    NSString *base64EncryptedString = [encryptedData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64EncryptedString;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
- (NSData*)rsaEncryptData:(NSData*)data publicKey: (SecKeyRef)spublicKey {
    SecKeyRef key = spublicKey;

    const uint8_t *srcbuf = (const uint8_t *)[data bytes];
    size_t srclen = (size_t)data.length;

    size_t block_size = SecKeyGetBlockSize(key) * sizeof(uint8_t);
    void *outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;

    NSMutableData *ret = [[NSMutableData alloc] init];
    for(int idx = 0; idx < srclen; idx += src_block_size){
        //        NSLog(@"%d/%d block_size: %d", idx, (int)srclen, (int)block_size);
        size_t data_len = srclen - idx;
        if (data_len > src_block_size) {
            data_len = src_block_size;
        }

        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyEncrypt(key,
                               kSecPaddingPKCS1,
                               srcbuf + idx,
                               data_len,
                               outbuf,
                               &outlen
                               );
        if (status != 0) {//0为成功
            NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)status);
            ret = nil;
            break;
        }else{
            [ret appendBytes:outbuf length:outlen];
        }
    }

    free(outbuf);
    return ret;
}

/// 将公钥SecKeyRef转为 nsdata
- (NSData *)getPublicKeyBitsFromKey:(SecKeyRef)givenKey {

    static const uint8_t publicKeyIdentifier[] = "com.inspur.publickey";
    NSData *publicTag = [[NSData alloc] initWithBytes:publicKeyIdentifier length:sizeof(publicKeyIdentifier)];

    OSStatus sanityCheck = noErr;
    NSData * publicKeyBits = nil;

    NSMutableDictionary * queryPublicKey = [[NSMutableDictionary alloc] init];
    [queryPublicKey setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [queryPublicKey setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];
    [queryPublicKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];

    // Temporarily add key to the Keychain, return as data:
    NSMutableDictionary * attributes = [queryPublicKey mutableCopy];
    [attributes setObject:(__bridge id)givenKey forKey:(__bridge id)kSecValueRef];
    [attributes setObject:@YES forKey:(__bridge id)kSecReturnData];
    CFTypeRef result;
    sanityCheck = SecItemAdd((__bridge CFDictionaryRef) attributes, &result);
    if (sanityCheck == errSecSuccess) {
        publicKeyBits = CFBridgingRelease(result);

        // Remove from Keychain again:
        (void)SecItemDelete((__bridge CFDictionaryRef) queryPublicKey);
    }

    return publicKeyBits;
}

/// 获取颁发机构名称
static NSString *CertificateGetISSUer(X509 *cert) {
    X509_NAME_ENTRY *name_entry;
    long Nid;
    unsigned char msginfo[1024];
    int msginfoLen;

    NSMutableString *issuerInfo = [[NSMutableString alloc] init];
    NSMutableString *certCN = [[NSMutableString alloc] init];

    X509_NAME *issuer = X509_get_issuer_name(cert);
    int entriesNum = sk_X509_NAME_ENTRY_num(issuer->entries);
    for (int i = 0; i < entriesNum; i++) {
        name_entry = sk_X509_NAME_ENTRY_value(issuer->entries, i);

        Nid = OBJ_obj2nid(name_entry->object);
        msginfoLen = name_entry->value->length;
        memcpy(msginfo,name_entry->value->data,msginfoLen);
        msginfo[msginfoLen]='\0';

        switch(Nid)
        {
            case NID_countryName://国家C
                [issuerInfo appendString:[NSString stringWithFormat:@"%s,",msginfo]];
                [certCN appendString:[NSString stringWithFormat:@"%s",msginfo]];
                break;

            case NID_stateOrProvinceName://省ST
                [issuerInfo appendString:[NSString stringWithFormat:@"%s,",msginfo]];
                break;

            case NID_localityName://地区L
                [issuerInfo appendString:[NSString stringWithFormat:@"%s,",msginfo]];
                break;

            case NID_organizationName://组织O=
                [issuerInfo appendString:[NSString stringWithFormat:@"%s,",msginfo]];
                break;

            case NID_organizationalUnitName://单位OU
                [issuerInfo appendString:[NSString stringWithFormat:@"%s,",msginfo]];
                break;

            case NID_commonName://通用名CN
                [issuerInfo appendString:[NSString stringWithFormat:@"%s",msginfo]];
                break;

            case NID_pkcs9_emailAddress://Mail
                break;

        }
    }
    return issuerInfo;
}

/// 从cer文件中获取过期时间
static NSDate *CertificateGetExpiryDate(X509 *certificateX509)
{
    NSDate *expiryDate = nil;
    if (certificateX509 != NULL) {
        ASN1_TIME *certificateExpiryASN1 = X509_get_notAfter(certificateX509);
        if (certificateExpiryASN1 != NULL) {
            ASN1_GENERALIZEDTIME *certificateExpiryASN1Generalized = ASN1_TIME_to_generalizedtime(certificateExpiryASN1, NULL);
            if (certificateExpiryASN1Generalized != NULL) {
                unsigned char *certificateExpiryData = ASN1_STRING_data(certificateExpiryASN1Generalized);
                NSString *expiryTimeStr = [NSString stringWithUTF8String:(char *)certificateExpiryData];
                NSDateComponents *expiryDateComponents = [[NSDateComponents alloc] init];
                expiryDateComponents.year   = [[expiryTimeStr substringWithRange:NSMakeRange(0, 4)] intValue];
                expiryDateComponents.month  = [[expiryTimeStr substringWithRange:NSMakeRange(4, 2)] intValue];
                expiryDateComponents.day    = [[expiryTimeStr substringWithRange:NSMakeRange(6, 2)] intValue];
                expiryDateComponents.hour   = [[expiryTimeStr substringWithRange:NSMakeRange(8, 2)] intValue];
                expiryDateComponents.minute = [[expiryTimeStr substringWithRange:NSMakeRange(10, 2)] intValue];
                expiryDateComponents.second = [[expiryTimeStr substringWithRange:NSMakeRange(12, 2)] intValue];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                expiryDate = [calendar dateFromComponents:expiryDateComponents];
            }
        }
    }
    return expiryDate;
}

/// 获取拥有者
static NSString *CertificateGetOwner(X509 *certificateX509) {
    char szOutCN[256]={0};
    X509_NAME *name = NULL;
    name = certificateX509->cert_info->subject;
    X509_NAME_get_text_by_NID(name,NID_commonName,szOutCN,256);
    NSString *nameStr = [NSString stringWithUTF8String:szOutCN];
    return nameStr;
}

@end
