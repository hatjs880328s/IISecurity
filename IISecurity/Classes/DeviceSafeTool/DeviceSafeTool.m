//
//  DeviceSafeTool.m
//

#import "DeviceSafeTool.h"
#import "IMPI18N.h"

@implementation DeviceSafeTool

// 常见不安全文件
const char *Unsafe_Tool_pathes[] = {
    "L0FwcGxpY2F0aW9ucy9DeWRpYS5hcHA=",
    "L0xpYnJhcnkvTW9iaWxlU3Vic3RyYXRlL01vYmlsZVN1YnN0cmF0ZS5keWxpYg==",
    "L2Jpbi9iYXNo",
    "L3Vzci9zYmluL3NzaGQ=",
    "L2V0Yy9hcHQ="
};

/** 当前设备是否不安全 */
+ (void)isDeviceUnsafe {
    BOOL isUnsafe = NO;
    // 判断是否存在不安全文件
    for (int i = 0; i < 5; i++) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:[NSString stringWithUTF8String:Unsafe_Tool_pathes[i]] options:0];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]]) {
            isUnsafe = YES;
        }
    }
    if (isUnsafe) {
        NSLog(@"此设备不安全!");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:IMPLocalizedString(@"iisafetool_tips_unsafe") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *continueAction = [UIAlertAction actionWithTitle:IMPLocalizedString(@"iisafetool_tips_continueuse") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *quitAction = [UIAlertAction actionWithTitle:IMPLocalizedString(@"iisafetool_tips_exit") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            exit(0);
        }];
        [alertController addAction:continueAction];
        [alertController addAction:quitAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        NSLog(@"此设备安全!");
    }
}

/** 文件是否被篡改 */
+ (void)isDocumentHasBeenTamper {
    BOOL isHasBeenTamper = NO;
    // 判断SignerIdentity是否存在
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:@"SignerIdentity"] != nil) {
        isHasBeenTamper = YES;
    }
    // 判断_CodeSignature、CodeResources、ResourceRules.plist是否存在
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/_CodeSignature",[bundle bundlePath]]] || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/CodeResources",[bundle bundlePath]]] || [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/ResourceRules.plist",[bundle bundlePath]]];
    if (!fileExists) {
        isHasBeenTamper = YES;
    }
    if (isHasBeenTamper) {
        // 这是被破解过的App
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:IMPLocalizedString(@"iisafetool_tips_cuangai") preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *quitAction = [UIAlertAction actionWithTitle:IMPLocalizedString(@"iisafetool_tips_exit") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            exit(0);
        }];
        [alertController addAction:quitAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

@end
