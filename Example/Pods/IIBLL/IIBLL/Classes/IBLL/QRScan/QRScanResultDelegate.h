//
//  QRScanResultDelegate.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/24.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QRScanResultDelegate <NSObject>
///二维码扫码结果
- (void)sendScanValue:(NSString *)value;
@end

