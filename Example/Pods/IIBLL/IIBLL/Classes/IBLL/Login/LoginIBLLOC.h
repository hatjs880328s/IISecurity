//
//  LoginIBLLOC.h
//  impcloud_dev
//
//  Created by 许阳 on 2019/4/4.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 此接口作用；
 将HTTP作为一个插件放到POD管理
 HTTP库引入此IBLL之后调用接口方法，启动服务时，需要进行IOC处理
 */

@protocol LoginIBLLOC <NSObject>

+ (void)doLogout;
+ (void)refreshMain;
- (void)IIPRIVATE_checkLoginForUser:(NSString *)user IIPRIVATE_withPassword:(NSString *)password;

@end

NS_ASSUME_NONNULL_BEGIN

//@protocol LoginIBLLOC
//
//+ (void)doLogout;
//+ (void)refreshMain;
//
//@end

NS_ASSUME_NONNULL_END
