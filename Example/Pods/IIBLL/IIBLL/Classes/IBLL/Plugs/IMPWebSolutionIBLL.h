//
//  IMPWebSolutionIBLL.h
//  impcloud_dev
//
//  Created by 衣凡 on 2019/5/27.
//  Copyright © 2019 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMPWebSolutionDelegate.h"
#import "BeeHive.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMPWebSolutionIBLL <BHServiceProtocol>
///EMMService-获取设备信息
- (NSString *)bll_EMMService_getDeviceInfo:(NSString *)callBackJSName;

///EMMService-刷新WebView
- (void)bll_EMMService_webviewReload;

///EMMService-刷新WebView
- (void)bll_EMMService_returnEMMstate:(NSDictionary *)jsonDict;

///OpenThirdAppService-打开第三方app
- (void)bll_OpenThirdAppService_openThirdApp:(NSDictionary *)jsonDict currentWebView:(UIView *)currentWebView;

///CameraService-选择照片
- (void)bll_CameraService_getPicture:(NSDictionary *)jsonDict params:(NSDictionary*)params currentView:(UIView *)currentWebView currentWindow:(UIViewController *)currentWindow jsCallBackDelegate:(id<IMPWebSolutionDelegate>)jsCallBackDelegate;

///CameraService-打开相机
- (void)bll_CameraService_displayCamera:(NSDictionary *)jsonDict currentView:(UIView *)currentWebView currentVC:(UIViewController *)currentVC;

///CameraService-清除successFunction
- (void)bll_CameraService_resetSuccessFunctionName;

///PhotoService-浏览图片
- (void)bll_PhotoService_viewImage:(UIViewController *)vc;

///PhotoService-拍照展示
- (void)bll_PhotoService_takePhotoAndUpload;

///PhotoService-初始化数据 需要先调用初始化传入必要配置
- (void)bll_PhotoService_initData:(NSDictionary *)jsonDic
                           params:(NSDictionary *)params
                          options:(NSDictionary *)options
                   currentWebView:(UIView *)currentWebView
                    currentWindow:(UIViewController *)currentWindow
               jsCallBackDelegate:(id<IMPWebSolutionDelegate>)jsCallBackDelegate;

///PhotoService-选择并上传图片
- (void)bll_PhotoService_getPicture;

///DeviceService-获取设备信息
- (NSString *)bll_DeviceService_getDeviceInfo;

///MapService-获取所有地图应用
- (NSString *)bll_MapService_getAllMapApps;

///MapService-打开地图应用 返回操作是否成功
- (BOOL)bll_MapService_doNaviByMapId:(NSString *)mapId destination:(NSString *)destination;

///MapService-高德地图导航
- (BOOL)bll_MapService_doAutoNavi:(NSDictionary *)dic;

///GpsService-开启gps
- (void)bll_GpsService_openGps;

///GpsService-关闭gps
- (void)bll_GpsService_closeGps;

///GpsService-获取地理位置
- (void)bll_GpsService_getInfoWithDelegate:(id<IMPWebSolutionDelegate>)gpsDelegate;

///GpsService-获取高德地理位置
- (void)bll_GpsService_getGDInfoWithDelegate:(id<IMPWebSolutionDelegate>)gpsDelegate;

//经纬度转换
- (void)bll_GpsService_getAddressWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic;

///StaffService-通讯录选人
- (void)bll_StaffService_selectStaff:(BOOL)isMultiSelect currentWindow:(UIViewController *)currentWindow delegate:(id<IMPWebSolutionDelegate>)delegate;

///StaffService-查看人员信息
- (void)bll_StaffService_viewStaff:(NSString *)staffID currentWindow:(UIViewController *)currentWindow;

///StaffService-获取用户信息
- (void)bll_StaffService_userInfoWithDelegate:(id<IMPWebSolutionDelegate>)delegate;

///WindowService-打开新窗口
- (void)bll_WindowService_openWindow:(NSDictionary *)params currentWebView:(UIView *)currentWebView viewController:(UIViewController *)viewController;

///WindowService-设置标题
- (void)bll_WindowService_setTitles:(NSDictionary *)params windowOfWebView:(UIViewController *)windowOfWebView;

///WindowService-设置导航栏右侧按钮
- (void)bll_WindowService_setMenus:(NSDictionary *)params windowOfWebView:(UIViewController *)windowOfWebView;

///FileService-文件服务初始化
- (void)bll_FileService_initData:(NSDictionary *)params currentWebView:(UIView *)webView;

///FileService-上传文件 需要先执行"文件服务初始化"方法以传入参数
- (void)bll_FileService_uploadFileWithDelegate:(id<IMPWebSolutionDelegate>)uploadDelegate;

///FileService-下载文件 需要先执行"文件服务初始化"方法以传入参数
- (void)bll_FileService_downloadfile:(id<IMPWebSolutionDelegate>)delegate needOpen:(BOOL)needOpen;

///FileService-选择文件 需要先执行"文件服务初始化"方法以传入参数
- (void)bll_FileService_selectFile:(id<IMPWebSolutionDelegate>)delegate;

///FileService-获取Base64字串 需要先执行"文件服务初始化"方法以传入参数
- (NSString *)bll_FileService_getBase64;

///FileService-写入文件 需要先执行"文件服务初始化"方法以传入参数
- (NSString *)bll_FileService_writeFile;

///FileService-读取文件 需要先执行"文件服务初始化"方法以传入参数
- (NSString *)bll_FileService_readFile;

///FileService-枚举列表 需要先执行"文件服务初始化"方法以传入参数
- (NSDictionary *)bll_FileService_listFile;

///FileService-删除文件 需要先执行"文件服务初始化"方法以传入参数
- (BOOL)bll_FileService_deleteFile;

///数据库操作-执行SQL
- (NSString *)bll_SqlService_executeSql:(NSString *)dataBaseName sql:(NSString *)sql success:(BOOL *)success;

///TelephoneService-拨打电话
- (void)bll_TelephoneService_call:(NSDictionary*)jsonParams;

///TelephoneService-直接进入拨打电话
- (void)bll_TelephoneService_dial:(NSDictionary*)jsonParams;

///NetworkService-获取网络类型
- (void)bll_NetworkService_getNetWorkTypeWithDelegate:(id<IMPWebSolutionDelegate>)delegate callBackName:(NSString *)name;

///VideoService-短视频拍摄
- (void)bll_VideoService_recordVideoWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic callBackName:(NSString *)name withVC:(UIViewController *)vc;

///VideoService-短视频播放
- (void)bll_VideoService_playVideoWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic withVC:(UIViewController *)vc;

///HttpService-Get方法
- (void)bll_HttpService_getWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic;

///ShareSocialService-分享文字
- (void)bll_ShareSocialService_shareTextWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic;

///ShareSocialService-分享Url
- (void)bll_ShareSocialService_shareUrlWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic;

///ShareSocialService-分享图片
- (void)bll_ShareSocialService_shareImageWithDelegate:(id<IMPWebSolutionDelegate>)delegate param:(NSDictionary *)dic;

///WechatService-微信发票
- (void)bll_WechatService_getInvoiceWithDelegate:(id<IMPWebSolutionDelegate>)delegate callBackSuccess:(NSString *)callBack_Success callBackFail:(NSString *)callBack_Fail;

@end

NS_ASSUME_NONNULL_END
