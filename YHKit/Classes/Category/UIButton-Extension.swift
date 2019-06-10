//
//  UIButton-Extension.swift
//  Alamofire
//
//  Created by nilhy on 2018/10/30.
//

import Foundation

private enum UIButtonPrivateKey {
    static var fontSizeKey = "fontSizeKey"
    static var hitTestEdgeInsetsKey = "hitTestEdgeInsetsKey"
}

public extension UIButton {
    
    ///提供属性供外部设置
    public var hitTestEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, &UIButtonPrivateKey.hitTestEdgeInsetsKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return (objc_getAssociatedObject(self, &UIButtonPrivateKey.hitTestEdgeInsetsKey) as? UIEdgeInsets) ?? UIEdgeInsets.zero
        }
    }
    
    ///重写点是否包含在view的区域内
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        if UIEdgeInsetsEqualToEdgeInsets(hitTestEdgeInsets!, UIEdgeInsets.zero) || !isEnabled || isHidden {
            return super.point(inside: point, with: event)
        }
        let relativeFrame = bounds
        let hitFrame = UIEdgeInsetsInsetRect(relativeFrame, hitTestEdgeInsets!)
        return hitFrame.contains(point)
    }
}

public extension UIButton {
    
    public convenience init(title : String,selectedTitle : String? = nil, color : UIColor = .black,font : UIFont = UIFont(name: "PingFangSC-Regular", size: 14)!, target : Any, action : Selector ) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitle(selectedTitle, for: .selected)
        self.adjustsImageWhenHighlighted = false
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        self.addTarget(target, action: action, for: .touchUpInside)
        self.sizeToFit()
    }
    
    public convenience init(imageName : String, selectedImageName : String? = nil, target : Any, action : Selector ) {
        self.init(title: "", target: target, action: action)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: selectedImageName ?? ""), for: .selected)
    }
}


//public extension UIButton {
//
//    @IBInspectable var fontName : String? {
//        get {
//            return self.titleLabel?.fontName
//        }
//        set {
//
//            guard let fontName = newValue else {
//                return
//            }
//            if let fontSize = objc_getAssociatedObject(self, &UIButtonPrivateKey.fontSizeKey) as? CGFloat {
//                self.titleLabel?.font = UIFont(name: fontName, size: fontSize)
//            } else {
//                self.titleLabel?.font = UIFont(name: fontName, size: 15)
//            }
//        }
//    }
//
//    @IBInspectable var fontSize : CGFloat {
//
//        get {
//            return self.titleLabel?.font.pointSize ?? 0
//        }
//        set {
//            guard newValue < 0 else {
//                return
//            }
//            objc_setAssociatedObject(self, &UIButtonPrivateKey.fontSizeKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//    }
//}

