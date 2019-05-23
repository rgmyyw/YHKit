//
//  UITextView-Extension.swift
//  YHKit
//
//  Created by nilhy on 2018/10/30.
//

import UIKit


public extension UITextView {
    
    /// 改变字间距和行间距 
    public func yh_changeSpace(lineSpace:CGFloat, wordSpace:CGFloat) {
        
        if self.text == nil || self.text == "" { return }
        
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedStringKey.kern:wordSpace])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}
