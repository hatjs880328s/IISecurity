//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IICacheManager.swift
//
// Created by    Noah Shan on 2018/6/15
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

// 对于中间件的作用说明：如果在产品进化过程中，yycache第三方需要替换或者更新，
// 只需要更新中间件内部方法的实现，对外暴露只增不减或者不变，业务方无需改动

/// YYCache中间件
public class IICacheManager: NSObject {
    
    private override init() {
        super.init()
    }
    
    static private var shareInstance: IICacheManager!
    
    @objc public static func getInstance() -> IICacheManager {
        if self.shareInstance == nil {
            self.shareInstance = IICacheManager()
        }
        return self.shareInstance
    }
    
    /// 缓存对象
    private let yycache = YYCache(name: IICacheStorage().iiCacheStorageName)
    
    /// 判定是否包含某个key
    public func isContains(key: String) -> Bool {
        if yycache == nil { return false }
        return self.yycache!.containsObject(forKey: key)
    }
    
    /// 存储一个对象，如果已经存在则覆盖
    public func saveObj(key: String, someThing: NSCoding) {
        self.yycache?.setObject(someThing, forKey: key)
    }
    
    /// 获取缓存数据根据key
    public func getObj(with key: String) -> NSCoding? {
        return self.yycache?.object(forKey: key)
    }
    
    /// 根据key删除某一段缓存
    @objc public func removeObj(with key: String) {
        self.yycache?.removeObject(forKey: key)
    }
    
    /// 谨慎使用，移除所有缓存
    public func removeAllCache() {
        self.yycache?.removeAllObjects()
    }
}
