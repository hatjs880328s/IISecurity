//
//  SearchSelectDelegate.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/23.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>
///通讯录选人完成后的代理
@protocol SearchSelectDelegate <NSObject>
@optional
///通讯录选取结果，获得选择的人员、群组、聊天频道数组
- (void)getSelectPeople:(NSMutableArray *)peopleArray groupArray:(NSMutableArray *)groupArray chatArray:(NSMutableArray *)chatArray;

///通讯录选取频道
- (void)getCid:(NSString *)str;

///通讯录完成选人-新闻分享给个人
- (void)shareForUser:(NSString *)uid;

@end
