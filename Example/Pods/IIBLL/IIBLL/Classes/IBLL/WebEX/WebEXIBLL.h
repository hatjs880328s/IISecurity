//
//  WebEXOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WebEXIBLL <BHServiceProtocol>

/// WEBEX入口
///
/// - Returns: vc
- (UIViewController *)getDoorVC;

@end

NS_ASSUME_NONNULL_END
