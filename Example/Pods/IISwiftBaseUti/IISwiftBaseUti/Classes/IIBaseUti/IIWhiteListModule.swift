//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIWhiteListModule.swift
//
// Created by    Noah Shan on 2018/9/27
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

@objc public enum IIWhiteListEnum: Int {
    case AOPNBPWhiteModule
    case ScreenShotClassWhiteModule
}

@objc public class IIWhiteListModule: NSObject {
    
    public var whiteListModules: [IIWhiteListEnum: IIWhiteModuleFather] = [:]
    
    public override init() {
        super.init()
        addNewListModule()
    }
    
    /// add new white module
    private func addNewListModule() {
        self.whiteListModules[IIWhiteListEnum.AOPNBPWhiteModule] = AOPNBPWhiteModule()
        self.whiteListModules[IIWhiteListEnum.ScreenShotClassWhiteModule] = ScreenShotClassWhiteModule()
    }
    
    /// get the value in the module
    @discardableResult
    @objc public func getRule(with key: String?, in table: IIWhiteListEnum) -> Bool {
        if key == nil { return false }
        if let keys = self.whiteListModules[table]?.list {
            for i in keys {
                if key == i {
                    return true
                }
            }
        }
        return false
    }
    
}

public class IIWhiteModuleFather: NSObject {
    public var list: [String] = []
    
    public override init() {
        super.init()
        addItems()
    }
    
    public func addItems() {}
}

/// aop - nbp white module
public class AOPNBPWhiteModule: IIWhiteModuleFather {
    
    public override func addItems() {

    }
}

/// shotscreen white module
public class ScreenShotClassWhiteModule: IIWhiteModuleFather {
    public override func addItems() {
        super.list.append("OpenWebviewViewController")
        super.list.append("NewsDetailComViewController")
        super.list.append("NewsComViewController")
    }
}
