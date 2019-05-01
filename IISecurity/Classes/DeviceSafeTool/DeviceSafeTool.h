//
//  DeviceSafeTool.h
//

#import <UIKit/UIKit.h>

@interface DeviceSafeTool : NSObject

/** 当前设备是否不安全 */
+ (void)isDeviceUnsafe;

/** 文件是否被篡改 */
+ (void)isDocumentHasBeenTamper;

@end
