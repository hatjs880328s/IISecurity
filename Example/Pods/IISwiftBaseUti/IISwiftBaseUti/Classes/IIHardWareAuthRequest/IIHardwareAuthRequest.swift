//
//  IIHardwareAuthRequest.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2018/8/27.
//  Copyright © 2018 Elliot. All rights reserved.
//

import Foundation

/*
 权限请求设置
 1.判定当前用户的权限状态
 2.如果没有提示过-先手动弹窗提示，之后用户点击开启再弹出系统级别，否则return[目的是可以一直弹出此提示]
 
 注意：
 此对象请设置为类中的成员变量，你懂的
 系统通用级别页面跳转使用新的url-scheme: https://blog.csdn.net/spicyShrimp/article/details/69946396
 
 */

public class IIHardwareAuthRequest: NSObject, UIAlertViewDelegate {
    
    /// 获取到权限回调
    public var successAction: (() -> Void)!
    /// 获取失败回调
    public var failAction:(() -> Void)!
    /// 已经做出判断的回调
    public var nilAction:(() -> Void)!
    /// 默认tag数值
    public let defaultTag = 10_010

    /// 跳转到配置页面
    public func openSettingPage() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.openURL(url)
        }
    }

    /// really wanna cry
    public func openSysSettingPage() {
        let jokeStr = "QXBwLVByZWZzOnJvb3Q9R" + "2VuZXJhbA=="
        guard let realJumpStr = Data(base64Encoded: jokeStr) else { return }
        guard let realStr = String(data: realJumpStr, encoding: String.Encoding.ascii) else { return }
        guard let realJumpURL = URL(string: realStr) else { return }
        UIApplication.shared.openURL(realJumpURL)
    }
    
    deinit {
        print("auth-functions-deinit...")
    }
}
