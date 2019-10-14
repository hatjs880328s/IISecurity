//
//  IMPWebSolutionDelegate.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/28.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IMPWebSolutionDelegate <NSObject>
@optional
///回调js
- (void)jsCallBack:(UIView *)webView andParams:(NSString*)params;

///返回定位经纬度
- (void)returnToWeb:(nullable NSDictionary *)dic;

///返回Json信息
- (void)jsonCallBackString:(nullable NSString *)jsonStr;

///文件上传结果
- (void)uploadFileResult:(BOOL)success param:(NSString *)param;

///文件下载成功返回路径
- (void)downloadFileResult:(BOOL)ifSuccess path:(NSString *)filePath fileName:(NSString *)filename showStr:(NSString *)showStr;
@end

NS_ASSUME_NONNULL_END
