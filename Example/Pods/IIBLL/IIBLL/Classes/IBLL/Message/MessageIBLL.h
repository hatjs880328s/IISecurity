//
//  MessageIBLL.h
//  impcloud
//
//  Created by 衣凡 on 2019/11/18.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^MessageBLLStringHandler)(BOOL success, NSString *stringInfo);
typedef void (^MessageBLLVCHandler)(BOOL success, UIViewController * _Nullable vc);
typedef void (^MessageBLLVoidHandler)(void);

@protocol MessageIBLL <BHServiceProtocol>
///获取未读消息总数
- (NSInteger)getMessageUnreadSum;

///创建群聊（根据会议创建群聊）
- (void)createGroupChannelByName:(NSString *)name members:(NSArray *)idArray handler:(MessageBLLStringHandler)handler;

///根据已有id获取群聊
- (UIViewController *)getChatVCByChannelId:(NSString *)channelId;

///更改频道名称
- (void)changeChannelName:(NSString *)channelId newName:(NSString *)name;

///添加群成员 传入要添加的人员id数组
- (void)addChannelPerson:(NSString *)channelId persons:(NSArray *)personIds;

///删除群成员 传入要删除的人员id数组
- (void)deleteChannelPerson:(NSString *)channelId persons:(NSArray *)personIds;

/// 扫码获取数据加入群聊
- (void)bll_analyzeQRCodeStrJoinGroup:(NSString *)codeStr handler:(MessageBLLVCHandler)handler;

#pragma mark - 系统邮件相关
/// 是否能够发送邮件
- (BOOL)judgeCanSendEmail;

/// 获取发送邮件视图，传入收件人，邮件视图的代理
- (UIViewController *)getEmailViewControllerByRecipients:(NSArray *)recipients composeDelegate:(id)delegate;

#pragma mark - 获取弹出提示框
/// 只有确认按钮
- (UIAlertController *)showSureAlertWithTitle:(NSString *)title;

/// 确认和取消按钮的提示
- (UIAlertController *)showAlertWithTitle:(NSString *)title SureBlock:(MessageBLLVoidHandler)handler;

@end
NS_ASSUME_NONNULL_END
