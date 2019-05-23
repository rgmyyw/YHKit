//
//  Double-Extension.swift
//  nilhy
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import Foundation

public extension CGFloat {
    
    public var toDouble: Double { return Double(self) }
    
    public var toFloat: Float { return Float(self) }
    
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    public var toString: String { return  NSString(format: "%f", self) as String }
    
    public var toUInt: UInt { return UInt(self) }
    
    public var toInt32: Int32 { return Int32(self) }
    
    
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
}

public extension Double {
    
    public var toFloat: Float { return Float(self) }
    
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    public var toString: String { return String(self) }
    
    public var toUInt: UInt { return UInt(self) }
    
    public var toInt32: Int32 { return Int32(self) }

}


public extension Int {
    
    public var toDouble: Double { return Double(self) }
    
    public var toFloat: Float { return Float(self) }
    
    public var toCGFloat: CGFloat { return CGFloat(self) }
    
    public var toString: String { return String(self) }
    
    public var toUInt: UInt { return UInt(self) }
    
    public var toInt32: Int32 { return Int32(self) }
    
    public static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
    
}



public extension String {
    
    
    public var toNSString: NSString { return self as NSString }
    
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    public mutating func trim() {
        self = self.trimmed()
    }
    
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    public func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    public func includesEmoji() -> Bool {
        for i in 0...count {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}



