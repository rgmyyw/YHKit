//
//  String+Rex.swift
//  YHKit
//
//  Created by nilhy on 2017/6/16.
//  Copyright © 2017年 nilhy. All rights reserved.
//

import UIKit


public struct RegexHelper {
    
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool {
        let matches = regex.matches(in: input,
                                            options: [],
                                            range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}


precedencegroup MatchPrecedence {
    associativity: none
    higherThan: DefaultPrecedence
}

infix operator =~: MatchPrecedence

public func =~(lhs: String, rhs: String) -> Bool {
    
    do {
        return try RegexHelper(rhs).match(lhs)
    } catch _ {
        return false
    }
}


public extension String {
   
    /**
     *  手机号有效性
     */
   public func yh_isMobileNumber() -> Bool {

        let x = self =~ "^1((3\\d|5[0-35-9]|8[0-9]|7[0-35-9])\\d|70[059])\\d{7}$"
        let y = self =~ "^0(10|2[0-57-9]|\\d{3})\\d{7,8}$"
        return x || y
    }
    
    /** 纯数字  */
    public func yh_isDigit() -> Bool {
        
        return self =~ "^[0-9]*$"
    }

    //// 是安全的支付密码? : 只支持重复数字
    public func yh_isSecurityPaymentPassword() -> Bool {
        
        return self =~ "^(?=.*\\d+)(?!.*?([\\d])\\1{5})[\\d]{6}$"
    }
    
    /** 是否为正常密码  */
    public func yh_isPassword() -> Bool {
        
        return self =~ "^[a-z0-9]{6,16}"
    }
    /** 是否为支付密码密码 6位数字  */
    public func yh_isSixPayPassword() -> Bool {
        
        return self =~ "^[0-9]{6,6}"
    }
    
    public func yh_isUserName() -> Bool {
        
        return self =~ "^[a-zA-Z][a-zA-Z0-9]{5,11}"
    }
    
    
    /** 是否为正常用户名 */
    public func is_user_nickName() -> Bool {
        
        return self =~ "^[\\u4e00-\\u9fa5_a-zA-Z0-9_]{1,10}"
    }
    
    /**
     *  邮箱的有效性
     */

    public func yh_isEmailAddress() -> Bool {
        return self =~ "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"//"[A-Za-z0-9._%+-]+[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    }
    
    /// 判断是不是Emoji
    ///
    /// - Returns: true false
    public func yh_containsEmoji()->Bool{
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F,
                 0x1F300...0x1F5FF,
                 0x1F680...0x1F6FF,
                 0x2600...0x26FF,
                 0x2700...0x27BF,
                 0xFE00...0xFE0F:
                return true
            default:
                continue
            }
        }
        
        return false
    }
 
    /// 判断是不是九宫格
    ///
    /// - Returns: true false
    public func yh_isNineKeyBoard()->Bool{
        let other : NSString = "➋➌➍➎➏➐➑➒"
        let len = self.count
        for _ in 0 ..< len {
            if !(other.range(of: self).location != NSNotFound) {
                return false
            }
        }
        
        return true
    }
    
}



