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

/// 由scheme跳转到当前日程 tab, 根据idx选中某一个二级选项[此时keywindow必须非alert,否则不起作用]
///
/// - Parameter itemIdx: 0：日程， 1:会议 2：任务
- (void) jump2WorkBenchVcThenShowOneItem: (NSInteger) itemIdx;

@end

NS_ASSUME_NONNULL_END
