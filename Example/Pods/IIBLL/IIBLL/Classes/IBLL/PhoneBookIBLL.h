//
//  PhoneBookIBLL.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/23.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeeHive.h"

NS_ASSUME_NONNULL_BEGIN


//通讯录 目前只是为了swift解耦暴露了需要的接口
@protocol PhoneBookIBLL <BHServiceProtocol>
@optional
//通过email查询通讯录人员的接口，返回NSObject，实际为PhoneBookUser对象
- (NSObject *)bll_getPhoneBookUserModelByMail:(NSString *)mail;

//跳转到通讯录选人界面
- (UIViewController *)jumpToSearchSelectViewController:(id _Nullable)delegate navTitle:(NSString *)navTitle selectOnlyPeopleArray:(NSMutableArray * _Nullable)selectOnlyPeopleArray selectOnlyGroupArray:(NSMutableArray * _Nullable)selectOnlyGroupArray selectOnlyChatArray:(NSMutableArray * _Nullable)selectOnlyChatArray selectNumFlag:(int)selectNumFlag selectPageFlag:(int)selectPageFlag selectContentFlag:(int)selectContentFlag isGroupHidden:(BOOL)isGroupHidden isFromTabbar:(BOOL)isFromTabbar peopleMaxNum:(NSInteger)peopleMaxNum shareText:(NSString * _Nullable)shareText;

/// 通讯录查询人员 str:搜索的字串 limitNum:搜索数量限制，传入-1时无限制 返回字典数组
- (NSArray *)bll_getPersonArraybyKey:(NSString *)str limitNum:(int)limit;

/// 通讯录人员头像 userId:人员Id 返回值:@{url : 头像url, img:本地生成的默认头像} 需要优先取url
- (NSDictionary *)getUserAvatarDic:(NSString *)userId;
@end

NS_ASSUME_NONNULL_END
