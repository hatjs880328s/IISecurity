//
//  MyViewExtension.swift
//  OMAPP
//
//  Created by 马耀 on 2017/2/23.
//  Copyright © 2017年 JNDZ. All rights reserved.
//

import UIKit

var blockActionDict: [String : ( () -> Void )] = [:]
public extension UIView {
    
    /// 获取cell所在的tableview
    public func cellTabViewController() -> UITableView? {
        var next = self.next
        while ( next != nil ) {
            if next!.isKind(of: UITableView.self) {
                guard let tabVc = next as? UITableView else { return nil }
                return tabVc
            }
            next = next?.next
        }
        return  nil
    }

    /// 返回所在控制器
    /// :returns: 所在控制器
    public func ViewController() -> UIViewController? {
        var next = self.next
        while((next) != nil) {
            if(next!.isKind(of: UIViewController.self)) {
                guard let rootVc = next as? UIViewController else { return nil }
                return rootVc
            }
            next = next?.next
        }
        return nil
    }
    
    /**
     view以及其子类的block点击方法
     - parameter action: 单击时执行的block
     */
    @objc public func tapActionsGesture(_ action:@escaping ( () -> Void )) {
        self.isUserInteractionEnabled = true
        addBlock(action)//添加点击block
        whenTouchOne()//点击block
    }
    
    fileprivate func addBlock(_ block:@escaping () -> Void) {
        //创建唯一标示  方便在点击的时候取出
        //        blockActionDict[String(NSValue(nonretainedObject: self))] = block
        blockActionDict[String(self.hashValue)] = block
    }
    
    fileprivate func whenTouchOne() {
        let tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTouchesRequired = 1
        tapGesture.numberOfTapsRequired = 1
        tapGesture.addTarget(self, action: #selector(UIView.tapActions))
        self.addGestureRecognizer(tapGesture)
    }
    
    /**
     私有方法，禁止调用
     */
    @objc func tapActions() {
        //取出唯一标示 并执行block里面的方法
        //        blockActionDict[String(NSValue(nonretainedObject:self))]!()
        blockActionDict[String(self.hashValue)]!()
    }
}
