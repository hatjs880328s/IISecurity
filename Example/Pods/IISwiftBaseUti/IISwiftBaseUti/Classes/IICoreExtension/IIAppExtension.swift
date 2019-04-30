//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIAppExtension.swift
//
// Created by    Noah Shan on 2018/7/25
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

public class IIAppExtension: NSObject {
    
    /// 获取fatherview
    @objc public func getFatherVc(selfVc: UIViewController) -> UIViewController? {
        if selfVc.navigationController == nil { return nil }
        if selfVc.navigationController!.viewControllers.count <= 1 { return nil }
        
        return selfVc.navigationController!.viewControllers[selfVc.navigationController!.viewControllers.count - 2]
    }

}

// MARK: - 获取正在显示的viewcontroller
public extension IIAppExtension {

    @objc public func topViewController() -> UIViewController? {
        return self.topViewWithRootVC(rootVC: getCurrentWindow()?.rootViewController)
    }

    @objc private func getCurrentWindow() -> UIWindow? {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindow.Level.normal {
            for eachItem in UIApplication.shared.windows {
                if eachItem.windowLevel == UIWindow.Level.normal {
                    window = eachItem
                    break
                }
            }
        }
        return window
    }

    @objc private func topViewWithRootVC(rootVC: UIViewController?) -> UIViewController? {
        guard let realRootVC = rootVC else { return nil }
        if let realRootvc = realRootVC.presentedViewController {
            return topViewWithRootVC(rootVC: realRootvc)
        }
        if realRootVC.isKind(of: UITabBarController.self) {
            guard let realBarVC = realRootVC as? UITabBarController else { return nil }
            return topViewWithRootVC(rootVC: realBarVC.selectedViewController)
        }
        if realRootVC.isKind(of: UINavigationController.self) {
            guard let realBarVC = realRootVC as? UINavigationController else { return nil }
            return topViewWithRootVC(rootVC: realBarVC.visibleViewController)
        }
        return realRootVC
    }
}

public extension UIViewController {

    /// 设置controller的描述方法
    @objc public func customDescription() -> String {
        //"应用<ApplicationViewController: 0x107099a00>"
        //"我<imp_cloud.CloudMineViewController: 0x106b7c640>"
        var originDescription = self.description
        originDescription = originDescription.replace(find: "<", replaceStr: "")
        originDescription = originDescription.replace(find: ">", replaceStr: "")
        if originDescription.contains(".") {
            //swift
            let subStr = (originDescription as NSString).components(separatedBy: ".").count >= 2 ? (originDescription as NSString).components(separatedBy: ".")[1] : ""
            let realSubStr = (subStr as NSString).components(separatedBy: ":").count >= 1 ? (subStr as NSString).components(separatedBy: ":")[0] : ""
            return realSubStr
        } else {
            //oc
            let realSubStr = (originDescription as NSString).components(separatedBy: ":").count >= 1 ? (originDescription as NSString).components(separatedBy: ":")[0] : ""
            return realSubStr
        }
    }
}
