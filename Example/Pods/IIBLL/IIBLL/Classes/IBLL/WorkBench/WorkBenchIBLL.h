//
//  WorkBenchOCIBLL.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/30.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  WorkBenchIBLL <BHServiceProtocol>

/// 获取入口vc
///
/// - Returns: vc
- (UIViewController *)doorVC;

/// 清除缓存 - 退出登录 & 切换账号
- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
