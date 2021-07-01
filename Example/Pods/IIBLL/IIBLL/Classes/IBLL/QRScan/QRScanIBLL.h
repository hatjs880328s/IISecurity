//
//  QRScanIBLL.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/24.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QRScanResultDelegate.h"
#import "BeeHive.h"

NS_ASSUME_NONNULL_BEGIN

@protocol QRScanIBLL <BHServiceProtocol>
///跳转到二维码扫描页
- (UIViewController *)getQRScanViewControllerWithDelegate:(_Nullable id<QRScanResultDelegate>)delegate isFrom3DTouch:(BOOL)from3DTouch;
@end


NS_ASSUME_NONNULL_END
