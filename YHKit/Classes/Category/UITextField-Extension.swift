//
//  UITextField-Extension.swift
//  nilhy
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

fileprivate extension UITextField {
    
    struct UITextFieldPrivateKeys {
        
        static var textFieldLimit : String = "textFieldLimitKey"
    }
}

public extension UITextField {
    
    
    /// Add left padding to the text in textfield
    public func addLeftTextPadding(_ blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }

    /// Add a image icon on the left side of the textfield
    public func addLeftIcon(_ image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, w: imageSize.width, h: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    
    
    
}


// MARK: - 其他功能扩展
public extension UITextField {
    
    /// textfield 限制长度
    ///
    /// - Parameter count: 长度
    public func yh_characterLimit(count : Int) {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        objc_setAssociatedObject(self, &UITextFieldPrivateKeys.textFieldLimit, count, .OBJC_ASSOCIATION_ASSIGN)
    }
    
    
    @objc private func textFieldDidChange(textField: UITextField) {
        
        guard let anyobj = objc_getAssociatedObject(self, &UITextFieldPrivateKeys.textFieldLimit) else { return }
        let count = anyobj as! Int
        if let content = textField.text, content.count >= count {
            textField.text = (content as NSString).substring(to: count);
        }
    }
}
