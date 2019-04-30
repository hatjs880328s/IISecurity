//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *
//
// IIL18NService.swift
//
// Created by    Noah Shan on 2018/6/13
// InspurEmail   shanwzh@inspur.com
//
// Copyright © 2018年 Inspur. All rights reserved.
//
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ** * * * *

import Foundation

/// 国际化字符串获取
public func getI18NStr(key: String, value: String = "", table: String? = nil) -> String {
    return IMPI18N.localizedString(forKey: key, value: value, table: table)
}
