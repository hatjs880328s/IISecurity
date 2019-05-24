//
//  UMShareIBLL.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/22.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UMShareIBLL.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ShareAction)(void);

//友盟分享
@protocol UMShareIBLL <BHServiceProtocol>

//友盟分享-纯文本
- (void)shareMessage:(NSString *)msg customizeButtonIcon:(UIImage *)img customizeButtonTitle:(NSString *)btnTitle block:(ShareAction)block;

//友盟分享-网址
- (void)shareTitle:(NSString *)title description:(NSString *)dec thumImage:(UIImage *)img webpageUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
