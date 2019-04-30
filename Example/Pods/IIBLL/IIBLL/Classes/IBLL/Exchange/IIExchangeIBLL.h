//
//  *******************************************
//  
//  IIExchanageIBLL.h
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/4/29.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 邮件模块FEATURE:


 *****************************
 功能：
 1.目前实现的是服务端加密&解密-C端对称加密传输的方式
 2.收发邮件 & 删除邮件 & 删除文件夹
 3.邮件详情展示-图片伪附件下载拼装
 *****************************

 *****************************
 待实现：
 1.Flag
 2.html详情页面监听了邮箱-但是没有带入到发送页面收件人
 *****************************

 *****************************
 关键点思路：
 1.关于附件：
 附件现在分为两部分
 a.真正的附件
 b.图片等资源
 他们都是按照附件的方式下载下来，详情页面附件tab中不展示伪附件（图片资源），但是附件资源列表中展示了所有的资源
 2.详情页面的缩放适配
 参照apple官方邮件app实现，关键点是将webview.scrollview.contentsize.height设置为0
 3.邮件详情与附件关系
 作为整体下载-原子性
 4.附件资源 & 邮件详情资源的存储
 邮件只有一级目录存储以.P7M文件结尾-是明文存储
 附件分emaild-folder / attachmentid-folder/ 多级目录存储
 5.多邮件账户
 目前登陆云+的账户可以添加多个邮件账号，在数据库中存储的有whose字段
 目前获取的用户信息是当前登陆云+账号的所有邮件账户的第一个
 清除缓存时，将所有信息删除包含所有账户
 6.证书处理
 目前是按照登陆云+用户的id存储
 并没有区分多账户
 *****************************

 */

typedef void (^Handler)(UIViewController * con);

///// 邮件功能模块对外暴露的接口
@protocol IIExchangeIBLL <BHServiceProtocol>

/// 获取到邮件首页
///
/// - Returns: 邮件首页vc
- (void)getVCWithSuccess:(Handler)handler;

/// 清除所有缓存
- (void)removeAllCache;

@end

NS_ASSUME_NONNULL_END
