//
//  UILabel-Extension.swift
//  YHkit
//
//  Created by nilhy on 2018/8/13.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit


public extension UILabel {
    
    /// 添加分割线
    public func yh_strikethroughText(text : String, color : UIColor?) {
        
        let attr = NSMutableAttributedString(string: text)
        attr.addAttribute(.strikethroughColor, value: color == nil ? self.textColor : color!, range: NSMakeRange(0, text.count))
        attr.addAttribute(.strikethroughStyle, value: NSNumber(value: 1), range: NSMakeRange(0, text.count))
        self.attributedText = attr
        self.sizeToFit()
    }
    
}
