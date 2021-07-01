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
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.left
        style.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: style]
        let leftNameSize = (text as NSString).boundingRect(with: CGSize(width: 1_0000, height: 25), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: attributes as [NSAttributedString.Key: Any], context: nil)
        return leftNameSize.width + 5
    }

    /// 使用label自适应高度计算高度
    @objc public func textHeightCalByLabel(realDes: String, font: UIFont, lineWeight: CGFloat) -> CGFloat {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = realDes
        label.font = font
        let size = label.sizeThatFits(CGSize(width: lineWeight, height: CGFloat(MAXFLOAT)))
        return size.height
    }

    /// 在源字符串中查找一共有多少目标字符串
    @objc public func getDirectStrCount(originTxt: String, itemStr: String, count: Int = 0) -> Int {
        let range = (originTxt as NSString).range(of: itemStr)
        var midcount = count
        if range.location == NSNotFound {
            return midcount
        } else {
            midcount += 1
            //替换掉查找到的目标并递归
            let midStr = (originTxt as NSString).replacingCharacters(in: range, with: "")
            return self.getDirectStrCount(originTxt: midStr, itemStr: itemStr, count: midcount)
        }
    }
    
    /// 计算在某个宽度和字体下，需要多少个文字
    @objc public func calculateChatCount(width: CGFloat, font: UIFont) -> Int {
        let originStr = "天上飘，来5个字"
        let number = 7.0

        let originWidth = IITextAndFontExtension().textLength(text: originStr, font: font)
        let eachWidth = originWidth / CGFloat(number)

        return Int(width / eachWidth)
    }

    /// 计算在某个宽度和字体条件下，第一行文字个数 [originstr: 源字符串 currentstr: 递归执行时需要的str]
    @objc public func calculateChatCount(width: CGFloat, font: UIFont, originStr: String, currentStr: String) -> Int {
        // 二分法计算
        let originWidth = IITextAndFontExtension().textLength(text: currentStr, font: font)
        if originWidth > width {
            // 取一半传入进去
            let subStr = currentStr.substringToIndex(currentStr.length / 2)
            if subStr.isEmpty { return currentStr.length }
            return calculateChatCount(width: width, font: font, originStr: originStr, currentStr: subStr)
        } else if width - originWidth > 10 {
            // width 大于 originwidth 并且 多余10px
            // 1.取出来剩下的字符串
            let lastStr = originStr.substringFromIndex(currentStr.length)
            // 2.遍历这个字符串直到相差小于10PX
            var gotStr = currentStr
            for eachchar in lastStr {
                gotStr += "\(eachchar)"
                let newWidth = IITextAndFontExtension().textLength(text: gotStr, font: font)
                if newWidth > width {
                    return gotStr.length - 1
                } else {
                    continue
                }
            }
            return gotStr.length
        } else {
            // width 大于 originwidth 并且 小于10px
            return currentStr.length
        }
    }
}
