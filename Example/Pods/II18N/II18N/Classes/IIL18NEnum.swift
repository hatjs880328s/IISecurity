//
//  III18NEnum.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/6/13.
//  Copyright © 2018年 Elliot. All rights reserved.
//

import Foundation
@_exported import II18N

public enum III18NEnum: String {
    // -------系统级别信息---------
    case http_not_realrequest = "Route_Alert_Tips"
    case http_request_error = "common_request_error"
    case http_request_unConnect = "common_request_unConnect"
    case http_request_timeout = "common_timeout"
    case Error_400_72001 = "Error_400_72001"
    case Error_400_72002 = "Error_400_72002"
    case Error_400_72003 = "Error_400_72003"
    case Error_400_72004 = "Error_400_72004"
    case Error_400_72005 = "Error_400_72005"
    case Error_400_72006 = "Error_400_72006"
    case Error_400_72101 = "Error_400_72101"
    case Error_400_72102 = "Error_400_72102"
    case Error_400_72103 = "Error_400_72103"
    case Error_400_72201 = "Error_400_72201"
    case Error_400_72202 = "Error_400_72202"
    case Error_400_41001 = "Error_400_41001"
    case Error_400_41002 = "Error_400_41002"
    case Error_400_72301 = "Error_400_72301"
    case app_alert_title = "common_alert"
    case app_alert_agree = "app_alert_agree"
    case app_alert_notAgree = "app_alert_notAgree"
    case app_alert_cancel = "Comment_Page_Cancel"
    case app_alert_setting = "todo_set_title"
    ///分享
    case app_share_txt = "app_share"
    /// 删除
    case app_delete_txt = "cloudDisk_fileOperate_delete"
    ///加载中
    case common_update = "common_update"
    //确定
    case app_btn_confirm = "todo_quickAdd_alertMessage_sure"
    //定位中
    case apple_location_txt = "Apple_Location_Txt"
    //位置选择
    case apple_locationSelect_title = "Apple_LocationSelect_Title"
    //位置
    case apple_location_title = "cloudDisk_fileOperate_detail_filePath"
    //地点搜索
    case apple_location_serach = "Apple_Location_Serach"
    //搜索無結果
    case apple_location_serach_noresult = "Apple_Location_Serach_NoResult"
    // -------个人中心首页---------
    case myFeedBack = "My_feedback"
    case myCustomerService = "Cloud_Page_Customer_Service"
    case mySetting = "My_setting"
    case myAboutUs = "My_setting_about"
    // -------个人中心-设置---------
    case perCenSet_security = "My_setting_currentDevice"
    case perCenSet_language = "My_selectLanguage_selectLanguage"
    case perCenSet_removeCache = "My_setting_clearCache"
    case perCenSet_webRe = "AppApplication_Rotation"
    case perCenSet_signOut = "My_setting_logout"
    case perCenSet_followSys = "My_selectLanguage_followSystem"
    // -------发现功能---------
    case discovery_mainpage_discovery = "discovery_mainpage_discovery"
    case discovery_mainpage_news = "discovery_mainpage_news"
    case discovery_mainpage_knowledge = "discovery_mainpage_knowledge"
    case discovery_mainpage_skills = "discovery_mainpage_skills"
    case discovery_mainpage_cardbox = "discovery_mainpage_cardbox"
    case discovery_mainpage_addapplications = "discovery_mainpage_addapplications"
    case discovery_mainpage_groupmessageinterruption = "discovery_mainpage_groupmessageinterruption"
    case discovery_mainpage_searchforcontacts = "discovery_mainpage_searchforcontacts"
    case discovery_mainpage_resizenewstext = "discovery_mainpage_resizenewstext"
    case discovery_cardmanager_managercard = "discovery_cardmanager_managercard"
    // -------音视频---------
    case agora_createChannel_fail = "agora_createChannel_fail"//加入失败
    case agora_channelUsers = "agora_channelUsers"//通话成员
    case agora_waittingforaccept = "agora_waittingforaccept"//等待接听
    case agora_talking = "agora_talking"//通话中
    case agora_someOne_invitau = "agora_someOne_invitau"//邀请你加入会话
    case agora_badNetState = "agora_badNetState"//当前通话质量不佳
    case agora_waitting_someone_accept = "agora_waitting_someone_accept"//正在等待对方接受邀请
    case agora_goodNetState = "agora_goodNetState"//網絡狀態良好
    case agora_txt_notalk = "agora_txt_notalk"//禁言
    case agora_txt_novoice = "agora_txt_novoice"//静音
    case agora_txt_speaker = "agora_txt_speaker"//免提
    case agora_txt_rejectJoin = "agora_txt_rejectJoin"//已拒绝
    case agora_call_someone = "agora_call_someone"//拨号中
    case agora_call_someone_fail = "agora_call_someone_fail"//拨号失败
    case agora_already_join_channel = "agora_already_join_channel"//您已在頻道中
    // -------webex---------
    case iiwebex_none = "iiwebex_none"//  無
    case iiwebex_whoseMeet = "iiwebex_whoseMeet"//  的会议
    case iiwebex_starttime  = "iiwebex_starttime"// 开始时间
    case iiwebex_durationtime = "iiwebex_durationtime"//持续时间
    case iiwebex_attendees = "iiwebex_attendees" //受邀请者
    case iiwebex_pwd = "iiwebex_pwd" //密码
    case iiwebex_setting = "iiwebex_setting"//设置
    case iiwebex_hours = "iiwebex_hours"//小时
    case iiwebex_mins = "iiwebex_mins"//分钟
    case iiwebex_person = "iiwebex_person"//人
    case iiwebex_startjoin = "iiwebex_startjoin"//开始
    case iiwebex_joinstart = "iiwebex_joinstart"//加入
    case iiwebex_years = "iiwebex_years"//年
    case iiwebex_months = "iiwebex_months"//月
    case iiwebex_days = "iiwebex_days"//日
    case iiwebex_invateCount = "iiwebex_invateCount"//您可一次邀请人
    case iiwebex_arrange = "iiwebex_arrange"//安排
    case iiwebex_completed = "iiwebex_completed"//完成
    case iiwebex_setPwdTxt = "iiwebex_setPwdTxt"//设置密码
    case iiwebex_addAttendees = "iiwebex_addAttendees"//添加受邀者
    case iiwebex_addAttenderEmail = "iiwebex_addAttenderEmail"//添加参加者的邮件地址
    case iiwebex_myMeet = "iiwebex_myMeet"//我的会议
    case iiwebex_meetDetailInfo = "iiwebex_meetDetailInfo"//会议信息
    case iiwebex_meetHost = "iiwebex_meetHost"//主持人
    case iiwebex_meetTime = "iiwebex_meetTime"//时间
    case iiwebex_meetNo = "iiwebex_meetNo"//会议号
    case iiwebex_meetPwd = "iiwebex_meetPwd"//会议密码
    case iiwebex_addPersonEmail = "iiwebex_addPersonEmail"//输入或选择参加者的邮件地址
    case iiwebex_createSuccess = "iiwebex_createSuccess"//創建成功
    case iiwebex_hostKey = "iiwebex_hostKey"//主持人key
    case iiwebex_mineTxt = "iiwebex_mineTxt"//我
    case iiwebex_deltip = "iiwebex_deltip"//提醒
    case iiwebex_deltil = "iiwebex_deltil"//確定刪除？
    case iiwebex_delfir = "iiwebex_delfir"//刪除
    case iiwebex_delcal = "iiwebex_delcal"//取消
    case iiwebex_pwderrorInfo = "iiwebex_pwderrorInfo"//密碼長度不對
    case iiwebex_pwdsuggectTitle = "iiwebex_pwdsuggectTitle"//密碼長度建議6-10
    case iiwebex_noContentSubTxt = "iiwebex_noContentSubTxt"//暫無會議內容
    case iiwebex_today = "iiwebex_today"//今天
    case iiwebex_selectPersonFromList = "iiwebex_selectPersonFromList"//從通訊錄中選擇
    case iiwebex_createSave = "iiwebex_createSave"//保存
    case iiwebex_meettitleAlert = "iiwebex_meettitleAlert"//w會議名稱不可為空
    case iiwebex_meetDownloadApp = "iiwebex_meetDownloadApp"//安装客户端？
    case iiwebex_meetDownloadConfirm = "iiwebex_meetDownloadConfirm"//安裝
    
    case iiwebex_moreThan20Person = "iiwebex_moreThan20Person"//超过了建议选择人数限制
    case iiwebex_innerPerson = "iiwebex_innerPerson"//内部参会人
    case iiwebex_outerPerson = "iiwebex_outerPerson"//外部参会人
    case iiwebex_addOuterPersonTitle = "iiwebex_addOuterPersonTitle"//添加外部参会人
    case iiwebex_addOuterPersonAdd = "iiwebex_addOuterPersonAdd"//添加
    case iiwebex_outPersonisExists = "iiwebex_outPersonisExists"//联系人已经存在
    
    case iiwebex_beforeNoMeet = "iiwebex_beforeNoMeet"//xx之前沒有會議
    case iiwebex_innerShare = "iiwebex_innerShare"//內部分享
    case iiwebex_emailError = "iiwebex_emailError"//郵箱格式不對
    case iiwebex_selectAttendees = "iiwebex_selectAttendees"//選擇參會人員
    case iiwebex_setPasteInfo = "iiwebex_setPasteInfo"//信息已復制
    case iiwebex_pwdCharError = "iiwebex_pwdCharError"//密碼字符不對
    // -------网络查件---------
    case iiwebUtil_uploadFile = "todo_attachment_selectAlert"//请选择文件
    case iiwebUtil_fromAlbum = "common_PhotoHome"//相册
    case iiwebUtil_fromcloudDisk = "cloudDisk"//云盘 cloudDisk
    case iiwebutil_fileselect_subtitle = "iiwebutil_fileselect_subtitle"//"已选{}\还可选择[]"
    case iiwebutil_filetail_notsubtxt = "iiwebutil_filetail_notsubtxt"//文件類型不符合要求，已過濾
    // -------网络监控---------
    case iinetwork_ob_badnetwork = "iinetwork_ob_badnetwork"//网络连接不稳定
    case iinetwork_ob_nonetwork = "iinetwork_ob_nonetwork"//网络连接发生问题，请检查你的网络设置
    case iinetwork_ob_nonetworkvc_title = "iinetwork_ob_nonetworkvc_title"//网络诊断
    case iinetwork_ob_nonetwork_check_hardware = "iinetwork_ob_nonetwork_check_hardware"//检测网络硬件链接
    case iinetwork_ob_nonetwork_check_wifihelper = "iinetwork_ob_nonetwork_check_wifihelper"//检测wifi路由器状态
    case iinetwork_ob_nonetwork_check_dnsservice = "iinetwork_ob_nonetwork_check_dnsservice"//检测DNS服务器状态
    case iinetwork_ob_nonetwork_check_hardware_detail = "iinetwork_ob_nonetwork_check_hardware_detail"//当前检查项目包含：设置硬件是否存在故障，硬件链接状态是否通畅，设置是否有链接wifi、4G、LTE等
    case iinetwork_ob_nonetwork_check_wifihelper_detail = "iinetwork_ob_nonetwork_check_wifihelper_detail"//当前检查项目包含：链接到的wifi是否有验证需求，如果有:需要先验证此wifi才可继续访问
    case iinetwork_ob_nonetwork_check_dnsservice_detail = "iinetwork_ob_nonetwork_check_dnsservice_detail"//当前检查项目包含：DNS服务是否有故障
    case iinetwork_ob_nonetwork_connect_wifihelper_title = "iinetwork_ob_nonetwork_connect_wifihelper_title"//网络认证";
    case iinetwork_ob_nonetwork_connect_wifihelper_wait = "iinetwork_ob_nonetwork_connect_wifihelper_wait"//正在加载网络认证页面,请稍候";
    case iinetwork_ob_check_repiretxt = "iinetwork_ob_check_repiretxt"//去修复
    case iinetwork_ob_check_hardwaresetting_certification = "iinetwork_ob_check_hardwaresetting_certification"//去認證
    case iinetwork_ob_check_repirehardware = "iinetwork_ob_check_repirehardware"//硬件链接修复"
    case iinetwork_ob_check_hardwaretxt = "iinetwork_ob_check_hardwaretxt"//建议按照以下方法检查网络硬件练接"
    case iinetwork_ob_check_hardwaresubone = "iinetwork_ob_check_hardwaresubone"//1.打开手机“设置”并把“Wi-Fi”开关保持开启状态。"
    case iinetwork_ob_check_hardwaresubtwo = "iinetwork_ob_check_hardwaresubtwo"//2.打开手机“设置”-“通用”-“蜂窝移动网络”，并把“蜂窝移动数据”开关保持开启状态。"
    case iinetwork_ob_check_hardwaresetting = "iinetwork_ob_check_hardwaresetting"//去设置"
    case iinetwork_check_host_baidu = "iinetwork_check_host_baidu"//百度
    case iinetwork_check_host_ali  = "iinetwork_check_host_ali"//阿里
    case iinetwork_check_host_inspur = "iinetwork_check_host_inspur"//浪潮
    case iinetwork_check_host_cloud = "iinetwork_check_host_cloud"//yun＋

    case iiPersonCenterChangeCompany = "Enterprise_Select_Change"//切换企业
    case iinetwork_longtimeNoRes = "iinetwork_longtimeNoRes"//长时间未响应
}
