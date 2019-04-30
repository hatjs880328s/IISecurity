//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IITextAndFontExtension.swift
//
// Created by    Noah Shan on 2018/7/11
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

public class IITextAndFontExtension: NSObject {
    
    /// 根据文字实际长度和需求长度返回合适的uifont[最多是几行]
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - length: 需求的长度
    ///   - originFont: 原始的uifont
    ///   - numberOfLines: 需求的行数
    /// - Returns: uifont
    @objc public func progressFontFitTxt(text: String, length: CGFloat, originFontSize: CGFloat, numberOfLines: Int = 1) -> UIFont {
        let reallength = self.textLength(text: text, font: UIFont.systemFont(ofSize: originFontSize))
        if reallength / length > CGFloat(numberOfLines) {
            let newFont = originFontSize - 0.1
            return self.progressFontFitTxt(text: text, length: length, originFontSize: newFont, numberOfLines: numberOfLines)
        } else {
            return UIFont.systemFont(ofSize: originFontSize)
        }
    }

    @objc public func progressRealHeight(textLength: CGFloat, eachLineWidth: CGFloat, eachLineHeight: CGFloat) -> CGFloat {
        let linetail = textLength.truncatingRemainder(dividingBy: eachLineWidth)
        if linetail == 0 {
            return textLength / eachLineWidth * eachLineHeight
        }
        return CGFloat(Int(textLength / eachLineWidth) + 1) * eachLineHeight
    }
    
    /// 计算文字宽度
    ///
    /// - Parameters:
    ///   - text: text
    ///   - font: font
    /// - Returns: 宽度
    @objc public func textLength(text: String, font: UIFont) -> CGFloat {
        let attributes = [kCTFontAttributeName: font]
        let leftNameSize = (text as NSString).boundingRect(with: CGSize(width: 1_000, height: 25), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key: Any], context: nil)
        return leftNameSize.width + 5
    }
}
