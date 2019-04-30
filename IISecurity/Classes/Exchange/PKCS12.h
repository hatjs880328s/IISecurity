//
//  PKCS12.h
//  EWS-For-iOS
//
//  Created by Noah_Shan on 2018/12/5.
//  Copyright © 2018 wangxk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKCS12 : NSObject

-(NSString *)signTheDataSHA1WithRSA:(NSString *)plainText pfxFiledatas:(NSData *)datas ;

-(NSString *)decrypt:(NSData *)datas;

/// 获取公钥
- (SecKeyRef)getPublicKey: (NSData *)pfxData pwd:(NSString *)passwords;

/// 获取私钥 & 校验证书
- (SecKeyRef)getPrivateKeyRefrenceFromData:(NSData*)p12Data password:(NSString*)password;

/**
 获取一个字典： 包含：颁发者，接受者，到期时间

 @param p12Data p12文件数据流Array<UInt8>
 @param password 密码
 @return @{@"EXPIRYDATE": expiryDate, @"POSTER": poster, @"OWNER": owner};
 */
- (NSDictionary *)getCERFileDetailInfos: (NSData *)p12Data password: (NSString *)password;


@end
