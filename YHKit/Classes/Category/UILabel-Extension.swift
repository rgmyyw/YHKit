//
//  UILabel-Extension.swift
//  YHkit
//
//  Created by nilhy on 2018/8/13.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

private enum UILabelPrivateKey {
    
    static var fontSizeKey = "fontSizeKey"
}

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

public extension UILabel {
    
    @IBInspectable var fontName : String?  {
        get {
            return self.font.fontName
        }
        set {
            
            guard let fontName = newValue else {
                return
            }
            if let fontSize = objc_getAssociatedObject(self, &UILabelPrivateKey.fontSizeKey) as? CGFloat {
                self.font = UIFont(name: fontName, size: fontSize)
            } else {
                self.font = UIFont(name: fontName, size: 14)
            }
        }
    }
    
    @IBInspectable var fontSize : CGFloat {
        
        get {
            return self.font.pointSize
        }
        set {
            guard newValue < 0 else {
                return
            }
            objc_setAssociatedObject(self, &UILabelPrivateKey.fontSizeKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}


