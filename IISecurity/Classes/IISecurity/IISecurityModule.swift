//
//  *******************************************
//  
//  IISecurityModule.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/1/14.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//

import Foundation
import IISwiftBaseUti
import IIBLL


/*
 安全性处理

 1.程序完整性校验

 2.长时间无响应检测 - 检测uiwindow的hittest方法- 只要手触碰屏幕就会触发

 3.UserDefault等加密
 */

public var changeDateNotification: String = "changeDateNotification"

public class IISecurityModule: NSObject {

    /// 长时间无响应时间
    static var changedDate: Date = Date()

    /// 长时间无响应的处理事件
    public static var longTimeNoResAction: AnyClass?

    /// 长时间无响应检测属性 - 发送接收到事件后的通知
    let appSendActionBlock:@convention(block) (_ id: AspectInfo) -> Void = { aspectInfo in
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: changeDateNotification), object: nil)
    }

    /// 弹窗类
    static var alertInfo: OTAlertVw?

    private static var shareInstance: IISecurityModule?

    private override init() {
        super.init()
    }

    @objc public static func getInstance() -> IISecurityModule {
        if self.shareInstance == nil {

            shareInstance = IISecurityModule()
            NotificationCenter.default.addObserver(self, selector: #selector(self.progressAspect), name: NSNotification.Name(rawValue: changeDateNotification), object: nil)
        }
        return self.shareInstance!
    }

    /// 如果是此vc-class 则忽略长时间无响应跳转
    public static var ignoreVC: AnyClass!

}

// MARK: - 长时间无响应
extension IISecurityModule {

    /// 设置长时间无响应的忽略的vc类
    public static func setIgnoreClass(igClass: AnyClass) {
        ignoreVC = igClass
    }

    /// aop获取uicontrol事件
    public func longTimeNoResponder() {
        do {
            try UIWindow.aspect_hook(#selector(UIWindow.hitTest(_:with:)),
                                      with: .init(rawValue: 0),
                                      usingBlock: appSendActionBlock)

        } catch {}
    }

    /// 处理时间
    /// 1.如果当前是登录页面则无需处理,但是需要重置时间
    /// 2.弹窗之后不必再弹窗，确定之后重置时间
    /// 3.没有超时时只需要重置时间
    @objc public static func progressAspect() {
        let date = Date()
        if IIAppExtension().topViewController()?.isKind(of: ignoreVC) ?? false {
            self.changedDate = date
            return
        }
        let ttMins: Double = 60 * 20
        if self.changedDate.distances(to: date) >= ttMins {
            //符合条件-应该退出了
            if alertInfo != nil { return }
            alertInfo = OTAlertVw()
            alertInfo?.alertShowSingleTitle(titleInfo: getI18NStr(key: III18NEnum.iiwebex_deltip.rawValue), message: getI18NStr(key: III18NEnum.iinetwork_longtimeNoRes.rawValue), from: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {
                (self.longTimeNoResAction as? LoginIBLLOC.Type)?.doLogout()
                self.changedDate = date
                alertInfo = nil
            }
        } else {
            //不符合条件-重置时间
            self.changedDate = date
        }
    }
}

/// 密码复杂度校验
extension IISecurityModule {

    /// 大写字母， 小写字母， 数字， 特殊字符
    ///
    /// - Parameters:
    ///   - pwd: 密码串
    ///   - typeCount: 种类数
    ///   - pwdMinCount: 最小位数
    ///   - pwdMaxCount: 最大位数
    /// - Returns: 是否符合要求
    @objc public func checkPwd(pwd: String, typeCount: Int = 3, pwdMinCount: Int = 8, pwdMaxCount: Int = 16) -> Bool {
        var typeDic = [Int: Int]()
        let num = RecognitionDoor.getInstance().recognition(with: pwd) ?? []
        for eachItem in num {
            switch eachItem.type {
            case .bankPwdNumCheck:
                typeDic[RecognitionInsType.bankPwdNumCheck.rawValue] = 1
            case .bankPwdSmallCharCheck:
                typeDic[RecognitionInsType.bankPwdSmallCharCheck.rawValue] = 1
            case .bankPwdBigCharCheck:
                typeDic[RecognitionInsType.bankPwdBigCharCheck.rawValue] = 1
            case .bankPwdSpecCharCheck:
                typeDic[RecognitionInsType.bankPwdSpecCharCheck.rawValue] = 1
            default:
                break
            }
        }
        if typeDic.keys.count >= typeCount && pwd.length >= pwdMinCount && pwd.length <= pwdMaxCount {
            return true
        }
        return false
    }
}

extension NSString {
    @objc public func getMd5Str() -> NSString {
        return (self as String).md5() as NSString
    }
}

extension NSData {
    @objc public func getMD5Str() -> String {
        return (self as Data).bytes.md5().toBase64() ?? ""
    }
}
