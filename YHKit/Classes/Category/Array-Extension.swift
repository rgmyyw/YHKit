//
//  Array-Extension.swift
//  YHKit
//
//  Created by nilhy on 2018/9/11.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import Foundation

public extension Array {
    
    /// 去除数组中重复数据
    ///
    /// - Parameter filter: 元素
    /// - Returns: 新数组
    public func yh_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}


