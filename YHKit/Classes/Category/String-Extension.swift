//
//  String-Extension.swift
//  nilhy
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

public extension String {
    
    /// 隐藏手机号码中间4位
    public func yh_hiddenMobileNumberFour() -> String {
        
        guard self.lengthOfBytes(using: .utf8) == 11 else { return self }
        return (self as NSString).replacingCharacters(in: NSRange(location: 3, length: 4), with: "****")
    }
    
    public func yh_urlEncoding() -> String? {
        let characters = "`#%^{}\"[]|\\<> "
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: characters).inverted)
    }
    
    /// json string >>> Dictionary
    public func yh_toDict() -> [String : Any]? {
        
        let jsonData : Data = self.data(using: .utf8)!
        
        do {
            let dict = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            return dict as? [String : Any]
            
        } catch {
            
            return nil
        }
    }
    
}

public extension String {
    
    /// 是否为连续数字
    public func yh_isContinuousNumber() -> Bool {
        
        guard Int(self) != nil else { return false }
        
        /// 记录上一个数字
        var lastAssiiNumber : UInt32?
        
        /// 遍历,得到 unicode
        for scalar in self.unicodeScalars {
            
            if lastAssiiNumber == nil {
                /// 第一次
                lastAssiiNumber = scalar.value
                
            } else {
                
                if (lastAssiiNumber! + 1) != scalar.value {
                    /// 不相同,直接 return
                    return false
                }
                lastAssiiNumber = scalar.value
            }
            print(scalar.value)
        }
        return true
    }
}

extension String {
    
    public func yh_htmlAttributeString() -> String {
        
        let html = self
        let str = "<img style='display: block; max-width: 100%;'"
        
        let htmlstring = (html as NSString).replacingOccurrences(of: "<img", with: str)
        
        let headHtml = "<html><head><meta http-equiv=\'Content-Type\' content=\'text/html; charset=utf-8\'/><meta content=\'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;\' name=\'viewport\' /><meta name=\'apple-mobile-web-app-capable\' content=\'yes\'><meta name=\'apple-mobile-web-app-status-bar-style\' content=\'black\'><link rel=\'stylesheet\' type=\'text/css\' /><style type=\'text/css\'> .color{color:#576b95;}</style></head><body><div id=\'content\'>\(htmlstring)</div>"
        return headHtml
    }
    
    
    /// 是否去除字符串中的表情
    ///
    /// - Parameter text: text
    func yh_disable_emoji(text : NSString)->String{
        do {
            let regex = try NSRegularExpression(pattern: "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]", options: NSRegularExpression.Options.caseInsensitive)
            
            let modifiedString = regex.stringByReplacingMatches(in: text as String, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, text.length), withTemplate: "")
            return modifiedString
        } catch {
            print(error)
        }
        return ""
    }
}




