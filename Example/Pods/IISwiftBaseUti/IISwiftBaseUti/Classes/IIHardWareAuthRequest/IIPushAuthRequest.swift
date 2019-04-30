//
//  *******************************************
//  
//  IIPushAuthRequest.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/4/26.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//

import UIKit
import UserNotifications

// MARK: 系统推送权限处理
@objc public class IIPushAuthRequest: IIHardwareAuthRequest {

    /// 获取是否有推送权限
    @objc public static func requestPUSHAuth(endAction: @escaping (_ result: Bool) -> Void) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings { (setting) in
                if setting.authorizationStatus == UNAuthorizationStatus.denied {
                    //没有权限
                    endAction(false)
                } else {
                    endAction(true)
                }
            }
        } else {
            guard let authSet = UIApplication.shared.currentUserNotificationSettings else { endAction(false) ; return }
            if authSet.types.rawValue == 0 {
                //没有权限
                endAction(false)
            } else {
                //有权限
                endAction(true)
            }
        }
    }
}
