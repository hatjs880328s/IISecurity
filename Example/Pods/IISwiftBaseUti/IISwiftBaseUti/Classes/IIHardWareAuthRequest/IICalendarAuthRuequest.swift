//
//  *******************************************
//  
//  IICalendarAuthRuequest.swift
//  impcloud_dev
//
//  Created by Noah_Shan on 2019/4/29.
//  Copyright © 2018 Inpur. All rights reserved.
//  
//  *******************************************
//

import Foundation
import EventKit

/// 请求日历访问权限处理
@objc public class IICalendarAuthRuequest: IIHardwareAuthRequest {

    @objc public override init() {
        super.init()
    }

    @objc public func requestAuth(endAction: @escaping (_ result: Bool) -> Void) {
        let store = EKEventStore()
        store.requestAccess(to: EKEntityType.event) { (granted, _) in
            if granted {
                endAction(true)
            } else {
                endAction(false)
            }
        }
    }
}
