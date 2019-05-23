//
//  UIButton-Extension.swift
//  Alamofire
//
//  Created by nilhy on 2018/10/30.
//

import Foundation


extension UIButton {
    
    ///提供多个运行时的key
    private struct RuntimeKey {
        static let btnKey = UnsafeRawPointer.init(bitPattern: "BTNKey".hashValue)
    }
    ///提供属性供外部设置
    public var hitTestEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, RuntimeKey.btnKey!, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return (objc_getAssociatedObject(self, RuntimeKey.btnKey!) as? UIEdgeInsets) ?? UIEdgeInsets.zero
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

