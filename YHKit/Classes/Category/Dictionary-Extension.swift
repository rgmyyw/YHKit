//
//  Dictionary-Extension.swift
//  YHKit
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import Foundation

public extension  Dictionary {
    
    /// Dictionary  >>>>  json string
    public func yh_jsonString() -> String {
        
        if (!JSONSerialization.isValidJSONObject(self)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : Data! = try! JSONSerialization.data(withJSONObject: self, options: [])
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
}
