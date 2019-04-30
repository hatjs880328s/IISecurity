//
//  IICoreExtension.swift
//  DingTalkCalander
//
//  Created by Noah_Shan on 2018/4/16.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import Foundation

public extension UIColor {
    
    /// 根据RGB生成图片
    ///
    /// - Parameters:
    ///   - colorLiteralRed: 红
    ///   - green: 绿
    ///   - blue: 蓝
    /// - Returns: 图片
   public class func toImage(colorLiteralRed: Float, green: Float, blue: Float, alpha: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        // 在这个范围开启一个上下文
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        // 在这段上下文中获取到颜色
        context?.setFillColor(red: CGFloat(colorLiteralRed), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
        // 填充这个颜色
        context?.fill(rect)
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
    
    /// 生成图片
    ///
    /// - Returns: 图片
    public func toImage(width: CGFloat? = 1, height: CGFloat? = 1) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        // 在这个范围开启一个上下文
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        // 填充这个颜色
        context?.fill(rect)
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return myImage!
    }
}
