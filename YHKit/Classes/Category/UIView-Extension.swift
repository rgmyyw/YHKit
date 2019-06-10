//
//  UIView-Extension.swift
//  YHKit
//
//  Created by nilhy on 2017/6/19.
//  Copyright © 2017年 nilhy. All rights reserved.
//

import UIKit


fileprivate extension UIView {
    
    struct UIViewPrivateKeys {
        
        static var enableDebugKey : String = "enableDebugKey"
        static var shoadowSubLayerKey : String = "shoadowSubLayerKey"
        static var gradientLayerKey : String = "gradientLayerKey"
    }
}

public extension UIView {

    /// 递归当前view并做一些事情
    public func yh_recursive( _ containsCurrent : Bool = false, _ handle : (UIView) -> (Void)) {
        
        if containsCurrent {
            handle(self)
        }
        
        for i in self.subviews {
            handle(i)
            i.yh_recursive(false, handle)
        }
    }
}

public extension UIView {
    
    /// 开启调试模式,为view 以及子viewz 自动设置随机颜色!
    public var enableDebug : Bool {
        
        set{
            
            objc_setAssociatedObject(self, &UIViewPrivateKeys.enableDebugKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if newValue == true {
                self.yh_recursive(true) { $0.backgroundColor = UIColor.random() }
            } else {
                self.yh_recursive(true) { $0.backgroundColor = .white }
            }
        }
        get{
            return objc_getAssociatedObject(self, &UIViewPrivateKeys.enableDebugKey) as? Bool ?? false
        }
    }
}

public extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue > 0 ? newValue : 0
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}


public extension UIView {
    
    /// 添加圆角和阴影: 采用子layer形式
    ///
    /// - Parameters:
    ///   - shadowOffset: 阴影偏移量
    ///   - radius: 圆角半径
    ///   - shadowOpacity: 阴影透明度 (0-1)
    ///   - shadowColor:  阴影颜色
    ///   - shadowRadius: 阴影半径，默认5
    public func yh_roundedShadow(cornerRadius:CGFloat,shadowOffset : CGSize, shadowOpacity:CGFloat, shadowColor:UIColor,shadowRadius : CGFloat = 5 ) {
        
        guard self.superview != nil else {
            return 
            //assert(false, "必须添加到superView")
        }
        
        if objc_getAssociatedObject(self, &UIViewPrivateKeys.shoadowSubLayerKey) != nil { return }
       
        /// 圆角
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        let subLayer = CALayer()
        subLayer.frame = self.frame
        subLayer.cornerRadius = cornerRadius
        subLayer.backgroundColor = UIColor.white.cgColor
        subLayer.masksToBounds = false
        subLayer.shadowColor = shadowColor.cgColor // 阴影颜色
        subLayer.shadowOffset = shadowOffset // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOpacity = Float(shadowOpacity) //阴影透明度
        subLayer.shadowRadius = shadowRadius;
        
        self.superview?.layer.insertSublayer(subLayer, below: self.layer)
        objc_setAssociatedObject(self, &UIViewPrivateKeys.shoadowSubLayerKey, subLayer, .OBJC_ASSOCIATION_RETAIN)
    }

    
    ///  给view 添加渐变色
    ///
    /// - Parameters:
    ///   - colors: 渐变色
    ///   - start: 开始点
    ///   - end: 结束点
    public func yh_gradient(colors : [UIColor], start : CGPoint , end : CGPoint )  {
        
        if objc_getAssociatedObject(self, &UIViewPrivateKeys.gradientLayerKey) != nil {
            return
        }
        
        var cgcolors = [CGColor]()
        for i in colors {
            cgcolors.append(i.cgColor)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = cgcolors
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
                
        //self.layer.addSublayer(gradientLayer) : 错误做法
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.setNeedsDisplay()
        objc_setAssociatedObject(self, &UIViewPrivateKeys.gradientLayerKey, gradientLayer, .OBJC_ASSOCIATION_RETAIN)
    }
    
    
    /// 清除渐变
    public func yh_clearGradient() {
        
        guard let subLayer = objc_getAssociatedObject(self, &UIViewPrivateKeys.gradientLayerKey) as? CAGradientLayer else {
            return
        }
        subLayer.removeFromSuperlayer()
        objc_setAssociatedObject(self, &UIViewPrivateKeys.gradientLayerKey, nil, .OBJC_ASSOCIATION_RETAIN)
    }
    
    
}

public extension UIView {
    
    /// 部分圆角,采用UIRectCorner 方式
    ///
    /// - Parameters:
    ///   - corners: 需要实现为圆角的角，可传入多个
    ///   - radii: 圆角半径
    public func yh_roundedCorners(corners: UIRectCorner, radii: CGFloat) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 高性能圆角4角 : 栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    ///
    /// - Parameter cornerRadius: 圆角半径
    public func yh_roundedCorners(radius : CGFloat) {
        
        self.layer.cornerRadius = radius   // 半径
        self.layer.masksToBounds = true
        //栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
    }
    
}


public extension UIView {
    
    public func yh_toImage(_ scale : CGFloat = UIScreen.main.scale) -> UIImage {
        
        self.layoutSubviews()
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func yh_isShowingOnKeyWindow() -> Bool {
        
        let newRect = UIApplication.shared.keyWindow?.convert(self.frame, from: self.superview)
        guard let lastNewRect = newRect else {
            return false
        }
        let isIntersects = UIApplication.shared.keyWindow?.bounds.intersects(lastNewRect) ?? false
        return !self.isHidden && self.alpha > 0.01 && self.window == UIApplication.shared.keyWindow && isIntersects;
    }
}

