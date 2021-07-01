//
//  IIPhotoAuthRequest.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/8/27.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation
import Photos

@_exported import II18N

/*
 相册权限请求设置,继承自[IIHardwareAuthRequest]-切记对象要用类成员变量
 流程：
 1.ios8+：获取系统权限之前使用 串行 方法authorizationStatus获取当前权限即可，如果是未选择：弹出选择
        框，用户选择同意之后在弹出系统级别[调用写方法]；如果已选择，则根据选择的状态做相应的处理。
 2.ios11+:获取系统权限之前使用 穿行 方法authorizationStatus获取当前权限，如果是为选择：弹出选择框，
        用户选择同意之后，调用异步的requestauth方法，当用户选择同意后在执行业务的写入方法；从第二次开始
        直接使用异步requestauth方法获取权限根据权限做出相应的处理
 
 */
public class IIPhotoAuthRequest: IIHardwareAuthRequest {
    
    /// 判定获取相册权限
    ///
    /// - Parameters:
    ///   - successAction: 用户点击开通权限
    ///   - failAction: 用户点击取消
    ///   - nilAction: 用户已经做出了选择
    @objc public func progressPhotoAuth(successAction:@escaping () -> Void, failAction:@escaping () -> Void, nilAction:@escaping () -> Void) {
        self.successAction = successAction
        self.failAction = failAction
        self.nilAction = nilAction
        if #available(iOS 11.0, *) {
            self.iOS11Plus()
        } else {
            self.iOS8Plue()
        }
    }
    
    /// ios11以上的处理方式
    public func iOS11Plus() {
        let authState = PHPhotoLibrary.authorizationStatus()
        // 第一次使用
        if authState == .notDetermined {
            switchProgressAuth(state: authState)
        } else {
            PHPhotoLibrary.requestAuthorization { (authState) in
                GCDUtils.toMianThreadProgressSome(youraction: {
                    self.switchProgressAuth(state: authState)
                })
            }
        }
    }
    
    /// ios8以上的处理方式
    public func iOS8Plue() {
        let authState = PHPhotoLibrary.authorizationStatus()
        self.switchProgressAuth(state: authState)
    }
    
    /// 枚举处理权限状态
    private func switchProgressAuth(state: PHAuthorizationStatus) {
        switch state {
        case .notDetermined:
            //[用户还没有做出选择]直接去请求即可
            //showRequestAlert()
            PHPhotoLibrary.requestAuthorization {
                if $0 != .authorized { return }
                GCDUtils.toMianThreadProgressSome(youraction: {
                    self.successAction()
                })
            }
        case .denied:
            //用户明确拒绝了使用相册的权限
            deniedRequestAlert()
        case .authorized:
            //允许使用，继续执行
            if self.nilAction == nil { break }
            nilAction()
        case .restricted:
            //家长控制一类的约束
            deniedRequestAlert()
        default:
            // ios14 (xcode 12) 新增的个配置 limited
            deniedRequestAlert()
        }
    }
    
    /// 用户没有选择权限时，弹窗提醒
    private func showRequestAlert() {
        let alert = UIAlertView(title: getI18NStr(key: III18NEnum.app_alert_title.rawValue), message: getI18NStr(key: "NSPhotoLibraryUsageDescription", value: "", table: "InfoPlist"), delegate: self, cancelButtonTitle: getI18NStr(key: III18NEnum.app_alert_notAgree.rawValue), otherButtonTitles: getI18NStr(key: III18NEnum.app_alert_agree.rawValue))
        alert.tag = self.defaultTag
        alert.show()
    }
    
    /// 用户拒绝后弹窗提醒
    private func deniedRequestAlert() {
        //[用户早已做出错误选择]
        let alert = UIAlertView(title: getI18NStr(key: III18NEnum.app_alert_title.rawValue), message: getI18NStr(key: "NSPhotoLibraryUsageDescription", value: "", table: "InfoPlist"), delegate: self, cancelButtonTitle: getI18NStr(key: III18NEnum.app_alert_cancel.rawValue), otherButtonTitles: getI18NStr(key: III18NEnum.app_alert_setting.rawValue))
        alert.show()
    }
    
    /// 系统回调
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == self.defaultTag {
            if buttonIndex == 0 {
                if self.failAction == nil { return }
                self.failAction()
                return
            }
            //同意逻辑-index:1
            if self.successAction == nil { return }
            if #available(iOS 11.0, *) {
                PHPhotoLibrary.requestAuthorization { (auth) in
                    if auth != .authorized { return }
                    GCDUtils.toMianThreadProgressSome(youraction: {
                        self.successAction()
                    })
                }
            } else {
                self.successAction()
            }
        } else {
            if buttonIndex == 1 {
                self.openSettingPage()
            }
        }
    }
}
