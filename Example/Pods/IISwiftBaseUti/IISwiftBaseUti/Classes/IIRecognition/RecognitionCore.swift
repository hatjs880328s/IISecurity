//
//  RecognitionCore.swift
//  SalveNumber
//
//  Created by Noah_Shan on 2018/7/18.
//  Copyright © 2018 Inspur. All rights reserved.
//

import Foundation

/*
 Swift4.0中正则规则如下：
 
 1.  .表示任意字符。空格也可以被表示
 2.  如果需要.本身，则需要使用\对其进行转义
 3.  "[mk]e.\\.s" 是 e的前面只能是 字母m或者k，然后后面跟一个任意字符，在后面是一个转义 . 最后是一个s[因为是在字符串中，所以\本身也需要被转义，所以.前面俩\]
 4.  自负集合空间eg:   [0-9A-Za-z]表示了任意数字 & 字母
 5.  取非操作使用 ^  eg,[^a-z]意思是除了a-z中的字符不可以，其他都可以
 6.  + 代表多个的含义： [a-z]+ 代表匹配一个或者多个 小写字母，不包含0个
 7.  * 代表0个或者多个的含义，和+区别是可以代表0个
 8.  {2，4}匹配重复的次数[a-z]{2,5}代表有2-5个小写字母
 9.  ()代表一个集合eg. (abc){3,5} 含义是：abc这三个字符循环 3-5次，（）内的代表了一个整体
 10. 前（正负）后（正负）查询-  (?=)向前[右为前] (?!)负向前[对向前查找进行取非而已]  (?<=)向后查找 (?<!)负向后查找
     eg.   "明天(?=[0-9])"代表：明天后面要求是数字，但是最后结果不显示后面的数字
 11. 条件查找eg.
        ( \\( )?                    \\d{3}   (?(1)\\)|-)                                            \\d{3}-\\d{4}
        代表(可有可无<子表达式编号1>    三个数字  如果条件1<1代表了第一个子表达式>成立就有一个 ）否则就有 -       三个数字 - 四个数字
 12. 多规则匹配的用法 let pattern = pattern1 + "|" + pattern2 + "|" + pattern3
 ...
 13. [解释为何四个\，因为\在正则里面就是源，所以要真正的\就需要对其进行转义，变为\\又因为是在字符串中，所以每一条\都需要+一个\进行字符串的转义所以就四个了]
 参考文档地址：https://www.jianshu.com/p/56da83a4e0ab
 */

public class RecognitionCore: NSObject {
    
    private static var shareInstance: RecognitionCore!
    
    /// rules
    public let patterns = RecognitionPatterns.getInstance().patterns
    
    private override init() {
        super.init()
    }
    
    public static func getInstance() -> RecognitionCore {
        if self.shareInstance == nil {
            self.shareInstance = RecognitionCore()
        }
        
        return self.shareInstance
    }
    
    /// 对外暴露的识别类
    public func recognitionLoop(strInfo: String) -> [RecognitionInstance] {
        var result: [RecognitionInstance] = []
        for eachItem in self.patterns {
            let midResult = self.recognition(str: strInfo, pattern: eachItem)
            if midResult == nil { continue }
            result.append(contentsOf: midResult!)
        }
        //排重
        let realResult = self.checkRepeat(checkInfo: result)
        //校验
        var validateResult = [RecognitionInstance]()
        for eachItem in realResult {
            let result = self.validateAndFormat(modelInfo: eachItem)
            if !result.0 { continue }
            validateResult.append(result.1)
        }
        
        return validateResult
    }
    
    /// 校验 & 格式化
    private func validateAndFormat(modelInfo: RecognitionInstance) -> (Bool, RecognitionInstance) {
        let validation = ValidateFactory.validate(with: modelInfo)
        let result = validation.validate(strInfo: modelInfo)
        
        return (result, validation.oldIns)
    }
    
    /// 排重
    private func checkRepeat(checkInfo: [RecognitionInstance]) -> [RecognitionInstance] {
        return checkInfo
        //目前不需要排重
//        var result = [RecognitionInstance]()
//        var removeIndex: [Int] = []
//        for i in 0 ... checkInfo.count - 1 {
//            for j in 0 ... checkInfo.count - 1 {
//                if checkInfo[i].range == checkInfo[j].range && j > i {
//                    removeIndex.append(j)
//                }
//            }
//        }
//        result = checkInfo
//        var removeindex = removeIndex.count - 1
//        while removeindex >= 0 {
//            result.remove(at: removeIndex[removeindex])
//            removeindex -= 1
//        }
//
//        return result
    }
    
    /// 单循环处理方法
    private func recognition(str: String, pattern: RECOGNITIONRULE) -> [RecognitionInstance]? {
        do {
            let regex = try NSRegularExpression(pattern: pattern.pattern, options: NSRegularExpression.Options.dotMatchesLineSeparators)
            let res = regex.matches(in: str, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: str.count))
            var result: [RecognitionInstance] = []
            for checkingRes in res {
                let patternStr = (str as NSString).substring(with: checkingRes.range)
                result.append(RecognitionInstance(range: checkingRes.range, type: pattern.type, rangeInfo: patternStr))
            }
            
            return result
        } catch {
            
            return nil
        }
    }
}
