//
//  RecognitionDoor.swift
//  SalveNumber
//
//  Created by Noah_Shan on 2018/7/18.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/// 识别入口类[lifecicle]
public class RecognitionDoor: NSObject {
    
    /// 是否开启服务
    private var isOpenService: Bool = true
    
    private static var instance: RecognitionDoor!
    
    private override init() {
        super.init()
    }
    
    @objc public static func getInstance() -> RecognitionDoor {
        if self.instance == nil {
            self.instance = RecognitionDoor()
        }
        return self.instance
    }
    
    @objc public func startService() {
        self.isOpenService = true
    }
    
    @objc public func stopService() {
        self.isOpenService = false
    }
}

// MARK: - [真正的业务逻辑]
public extension RecognitionDoor {
    
    /// 识别方法
    ///
    /// - Parameter info: 需要被识别的字符串
    /// - Returns: 识别出来信息数组，如果nil则说明服务未开启
    @objc public func recognition(with info: String) -> [RecognitionInstance]? {
        //服务关闭
        if !self.isOpenService { return nil }
        let result = RecognitionCore.getInstance().recognitionLoop(strInfo: info)
        
        return result
    }
    
}
