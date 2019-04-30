//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// RecognitionValidate.swift
//
// Created by    Noah Shan on 2018/7/18
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

/*
 校验代码：
 1.校验日期是否正确2017-2-29
 2.校验星期是否已经过去
 3.校验今天、明天、后天代表的真正日期
 4.格式化输出[2018-9-9是否有必要转为2018-09-09]
 */

class ValidateFactory: NSObject {
    
    class func validate(with model: RecognitionInstance) -> RecognitionValidate {
        switch model.type {
        case .week:
            return RecognitionValidateWeek()
        case .phoneNumber:
            return RecognitionValidatePhoneno()
        case .date:
            return RecognitionValidateDate()
        case .today:
            return RecognitionValidateToday()
        default:
            return RecognitionValidate()
        }
    }
}

/// 校验类父类
class RecognitionValidate: NSObject {
    
    var oldIns: RecognitionInstance!
    
    @discardableResult
    func validate(strInfo: RecognitionInstance) -> Bool {
        self.oldIns = strInfo
        
        return true
    }
    
}

/// 校验日期&format
class RecognitionValidateDate: RecognitionValidate {
    
    override func validate(strInfo: RecognitionInstance) -> Bool {
        super.validate(strInfo: strInfo)
        var containsCount = 0
        var sepChar = String()
        //对分隔符进行判定 & 处理
        let sepArrs = [":", "-", "\\", "/", "："]
        for eachItem in sepArrs {
            if strInfo.rangeInfo.contains(eachItem) {
                containsCount += 1
                sepChar = eachItem
            }
        }
        if containsCount == 1 {
            return progressLeapyear(sepChar: sepChar, progressStr: strInfo.rangeInfo)
        }
        
        return false
    }
    
    /// 判定是否是闰年（使用todate方法校验即可）
    func progressLeapyear(sepChar: String, progressStr: String) -> Bool {
        let newIns = progressStr.replace(find: sepChar, replaceStr: "-")
        let newDate = newIns.toDate()
        if newDate == nil { return false }
        // 给realdate赋值
        self.oldIns.realDateInfo = newDate!
        
        return true
    }
    
}

/// 校验周X
class RecognitionValidateWeek: RecognitionValidate {
    
    override func validate(strInfo: RecognitionInstance) -> Bool {
        super.validate(strInfo: strInfo)
        return self.validateWeek(validateStr: strInfo.rangeInfo)
    }
    
    /// 校验星期数是否是在今天或者今天之后
    private func validateWeek(validateStr: String) -> Bool {
        let dateNow = Date().weekday
        var validateWeek: Int = 0
        switch validateStr {
        case let str where str.contains("天") || str.contains("7"):
            validateWeek = 1
        case let str where str.contains("六") || str.contains("6"):
            validateWeek = 7
        case let str where str.contains("五") || str.contains("5"):
            validateWeek = 6
        case let str where str.contains("四") || str.contains("4"):
            validateWeek = 5
        case let str where str.contains("三") || str.contains("3"):
            validateWeek = 4
        case let str where str.contains("二") || str.contains("2"):
            validateWeek = 3
        case let str where str.contains("一") || str.contains("1"):
            validateWeek = 2
        default:
            break
        }
        if dateNow <= validateWeek {
            //给realdate赋值
            self.oldIns.realDateInfo = Date().addDays(validateWeek - dateNow)
            
            return true
        }
        
        return false
    }
    
}

/// 校验手机号
class RecognitionValidatePhoneno: RecognitionValidate {
    
    override func validate(strInfo: RecognitionInstance) -> Bool {
        super.validate(strInfo: strInfo)
        return true
    }
    
}

/// 校验 今天明天后天
class RecognitionValidateToday: RecognitionValidate {
    override func validate(strInfo: RecognitionInstance) -> Bool {
        super.validate(strInfo: strInfo)
        self.formatDateInfo()
        
        return true
    }
    
    /// format date
    private func formatDateInfo() {
        switch self.oldIns.rangeInfo {
        case "今天":
            self.oldIns.realDateInfo = Date()
        case "明天":
            self.oldIns.realDateInfo = Date().addDays(1)
        case "后天":
            self.oldIns.realDateInfo = Date().addDays(2)
        default:
            return
        }
    }
}
