//
//  DiscoverOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DiscoverIBLL <BHServiceProtocol>

/// 跳转到发现首页
///
/// - Returns: 发现首页vc
-(UIViewController *)jumpToDiscoverVC;

/// 跳转到卡包页面
///
/// - Returns: 卡包页面
-(UIViewController *)jumpToCardBoxVC;

@end

NS_ASSUME_NONNULL_END
