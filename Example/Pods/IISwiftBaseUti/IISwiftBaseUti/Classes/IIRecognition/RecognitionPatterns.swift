//
//  RecognitionPatterns.swift
//  SalveNumber
//
//  Created by Noah_Shan on 2018/7/18.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/// recognition - rule
public typealias RECOGNITIONRULE = (name: String, pattern: String, type: RecognitionInsType)

/// 规则类
public class RecognitionPatterns: NSObject {
    
    public var patterns: [RECOGNITIONRULE] = []
    
    public static var shareInstance: RecognitionPatterns!
    
    public static func getInstance() -> RecognitionPatterns {
        if self.shareInstance == nil {
            self.shareInstance = RecognitionPatterns()
        }
        return shareInstance
    }
    
    private override init() {
        super.init()
        addPattern()
    }
    
    private func addPattern() {
        let today = ("today", "(今天|明天|后天)", RecognitionInsType.today)
        self.patterns.append(today)

        //分隔符如果添加的话，需要在validate类中也添加
        let dateInfo = ("dateInfo", "(?<![0-9])2[0-9]{3}[/\\-:\\\\：]([0][123456789]|[1][012]|[123456789])[/\\-:\\\\：]([0][123456789]|[12][0-9]|[123456789]|[3][01])(?![0-9])", RecognitionInsType.date)
        self.patterns.append(dateInfo)

        let numberJoinwithChar = ("numberJoinwithChar", "(?<![0-9])1\\d{10}(?![0-9])", RecognitionInsType.phoneNumber)
        self.patterns.append(numberJoinwithChar)

        let week = ("week", "[(星期)|周][一二三四五六天1234567]", RecognitionInsType.week)
        self.patterns.append(week)

        ///匹配所有邮箱结尾为 com,cn
        let email = ("email", "([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.(com|cn|net)", RecognitionInsType.email)
        self.patterns.append(email)

        let sessionTicket = ("sessionTicket", "\\<SessionTicket\\>[\\S\\s]+\\</SessionTicket\\>", RecognitionInsType.sessionTicket)
        self.patterns.append(sessionTicket)

        let pwdCheck = ("pwdCheck", "[^a-zA-Z0-9]", RecognitionInsType.pwdCheck)
        self.patterns.append(pwdCheck)

        /// 这里 \\p{S}\\p{P}\\p{C} 表示特殊字符
        //数字，大写字母，小写字母，特殊符号   4选3  大于8 位  "^(?![0-9]+$)(?![a-z]+$)(?![A-Z]+$)(?![\\p{S}\\p{P}\\p{C}]+$)(?![A-Za-z]+$)(?![A-Z0-9]+$)(?![a-z0-9]+$)(?![a-z\\p{S}\\p{P}\\p{C}]+$)(?![0-9\\p{S}\\p{P}\\p{C}]+$)(?![A-Z\\p{S}\\p{P}\\p{C}]+$)[0-9A-Za-z\\p{S}\\p{P}\\p{C}]{4,16}$"
        let bankPwdCheckNum = ("bankPwdNumCheck", "[0-9]", RecognitionInsType.bankPwdNumCheck)
        self.patterns.append(bankPwdCheckNum)

        let bankPwdCheckSmallChar = ("bankPwdSmallCharCheck", "[a-z]+", RecognitionInsType.bankPwdSmallCharCheck)
        self.patterns.append(bankPwdCheckSmallChar)

        let bankPwdCheckBigChar = ("bankPwdBigCharCheck", "[A-Z]+", RecognitionInsType.bankPwdBigCharCheck)
        self.patterns.append(bankPwdCheckBigChar)

        let bankPwdCheckSpecChar = ("bankPwdSpecCharCheck", "[\\p{S}\\p{P}\\p{C}]+", RecognitionInsType.bankPwdSpecCharCheck)
        self.patterns.append(bankPwdCheckSpecChar)
    }
}
