//
//  Date.swift
//  nilhy
//
//  Created by Arvin on 2018/4/13.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import Foundation


public extension Int {
    
    /// 格式化自定义时间: 刚刚,一分之前,两分钟
    public func yh_timestampFormat() -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(exactly: self)!)
        return date.yh_createDateString()
    }
    
    
    /// 格式化时间戳yyyy-MM-dd HH:mm
    ///
    /// - Parameter format: 需要的格式,r默认yyyy-MM-dd HH:mm
    /// - Returns: 返回字符串
    public func yh_timestampFormat(format : String = "yyyy-MM-dd HH:mm") -> String {
        
        if self <= 0 {
            return ""
        }
        
        let fmt = DateFormatter()
        fmt.dateFormat = format
        fmt.locale = Locale.current
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        return fmt.string(from: date)
    }
}


public extension Date {
    
    public func yh_createDateString() -> String {
        
        // 1.创建时间格式化对象
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        fmt.locale = Locale(identifier: "en")
        
        // 2.将字符串时间,转成NSDate类型
        
        //guard let createDate = fmt.date(from: self) else {
            //return ""
        //}
        let createDate = self
        
        
        // 3.创建当前时间
        let nowDate = Date()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        // 5.对时间间隔处理
        // 5.1.显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2.59分钟前
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        
        
        // 5.3.11小时前
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        
        // 5.3.6小时前
        if interval < 60 * 60 * 6 {
            return "\(interval / (60 * 60))小时前"
        }

        
        // 5.4.创建日历对象
        let calendar = NSCalendar.current
        
        
        // 5.4.1.处理昨天数据: 今天 12:23
        if calendar.isDateInToday(createDate) {
            fmt.dateFormat = "今天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        
        // 5.5.处理昨天数据: 昨天 12:23
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.6.处理一年之内: 02-22 12:22

        ///let cmps = calendar.components(.Year, fromDate: createDate, toDate: nowDate, options: [])
        
        let cmps = calendar.dateComponents([.year], from: createDate, to: nowDate)
        
        if cmps.year! < 1 {
            
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: createDate)
            return timeStr
        }
        
        // 5.7.超过一年: 2014-02-12 13:22
        fmt.dateFormat = "yyyy-MM-dd HH:mm"
        let timeStr = fmt.string(from: createDate)
        return timeStr
    }
}
