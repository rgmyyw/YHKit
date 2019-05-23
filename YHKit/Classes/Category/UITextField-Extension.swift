//
//  UITextField-Extension.swift
//  nilhy
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

public extension UITextField {
    
    public enum TextFieldMarginDirection {
        case left
        case right
    }
    
    /// 给 textField 添加间距
    public func addTextFieldMargin(direction : TextFieldMarginDirection,width : CGFloat = 10) {
        
        switch direction {
        case .left:
            
            let view : UIView = UIView()
            view.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            self.leftView = view
            self.leftViewMode = .always
            
        case .right:
            
            let view : UIView = UIView()
            view.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            self.rightView = view
            self.rightViewMode = .always
        }
    }
    
}


public extension UITextField {
    
    private struct UITextFieldKey {
        static var textFieldLimitKey = "textFieldLimitKey"
    }
    
    /// textfield 限制长度
    ///
    /// - Parameter count: 长度
    public func yh_characterLimit(count : Int) {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        objc_setAssociatedObject(self, &UITextFieldKey.textFieldLimitKey, count, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        guard let anyobj = objc_getAssociatedObject(self, &UITextFieldKey.textFieldLimitKey) else { return }
        
        let count = anyobj as! Int
        if let content = textField.text, content.count >= count {
            textField.text = (content as NSString).substring(to: count);
        }
    }
}
