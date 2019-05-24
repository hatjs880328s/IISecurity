//
//  OTAlertVw.swift
//  OralStunts
//
//  Created by Noah_Shan on 2018/5/18.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation
@_exported import II18N

public class OTAlertVw: NSObject {

    let cancelTxt = getI18NStr(key: "Comment_Page_Cancel")

    let doneTxt = getI18NStr(key: "iiexcNaviDone")

    public override init() {
        super.init()
    }
    
    /// 单行文档提示
    public func alertShowSingleTitle(titleInfo: String, message: String, from: UIViewController, action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: titleInfo, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: doneTxt, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(cancelAction)
        from.present(alert, animated: true, completion: nil)
    }
    /// 两个按钮的提示
    public func alertShowConfirm(title: String, message: String, from: UIViewController, confirmStr: String, confirmAction:@escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: cancelTxt, style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(cancelAction)
        let confirmAction = UIAlertAction(title: confirmStr, style: UIAlertAction.Style.destructive, handler: confirmAction)
        alert.addAction(confirmAction)
        from.present(alert, animated: true, completion: nil)
    }
}
