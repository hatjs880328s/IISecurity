//
//  UMShareIBLL.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/22.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShareAction)(void);

//友盟分享
@protocol UMShareIBLL <BHServiceProtocol>

//友盟分享-纯文本-WebEX
- (void)shareMessage:(NSString *)msg customizeButtonIcon:(UIImage *)img customizeButtonTitle:(NSString *)btnTitle block:(id)block;

//友盟分享-网址-关于
- (void)shareTitle:(NSString *)title description:(NSString *)dec thumImage:(UIImage *)img webpageUrl:(NSString *)url;

//JS分享插件-文本
- (void)shareJSText:(NSString *)text;

//JS分享插件-Url
- (void)shareJSUrl:(NSString *)url title:(NSString *)title description:(NSString *)dec thumImage:(id)thumImage;

//JS分享插件-图像
- (void)shareJSImage:(id)img title:(NSString *)title description:(NSString *)dec thumImage:(id)thumImage;

- (void)shareIMG:(UIImage *)img title:(NSString *)title msg:(NSString *)msg customPlt:(NSString *)plt block:(id)block;


@end

NS_ASSUME_NONNULL_END
