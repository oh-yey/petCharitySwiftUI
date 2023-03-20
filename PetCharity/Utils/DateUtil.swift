//
//  DateUtil.swift
//  PetCharity
//
//  Created by 黄嘉豪 on 2023/3/10.
//

import Foundation

// 字符串 -> 日期
func string2Date(_ string: String, dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "zh_CN")
    dateFormatter.dateFormat = dateFormat
    if let date = dateFormatter.date(from: string) {
        return date
    }
    return nil
}

// 日期 -> 字符串
func data2String(_ date:Date , dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "zh_CN")
    dateFormatter.dateFormat = dateFormat
    return dateFormatter.string(from: date)
}

// Django字符串 -> 字符串
func django2String(_ dateStr: String?, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
    if dateStr == nil {
        return "----"
    }
    if let date = string2Date(dateStr!) {
        return data2String(date, dateFormat: dateFormat)
    }
    return "---"
}
