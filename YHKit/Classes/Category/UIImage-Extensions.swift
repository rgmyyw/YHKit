//
//  UIImage-Extensions.swift
//  WeiBo
//
//  Created by yaowei on 2016/7/5.
//  Copyright © 2016年 itcast. All rights reserved.
//

import UIKit

public extension UIImage {
    
    /// 创建头像图像
    ///
    /// - parameter size:      尺寸
    /// - parameter backColor: 背景颜色
    ///
    /// - returns: 裁切后的图像
    public func yh_avatarImage(size: CGSize?, backColor: UIColor = UIColor.lightGray, lineColor: UIColor = UIColor.orange) -> UIImage? {
        
        var size = size
        if size == nil || size?.width == 0 {
            size = CGSize(width: 34, height: 34)
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, UIScreen.main.scale)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        let ovalPath = UIBezierPath(ovalIn: rect)
        ovalPath.lineWidth = 1
        lineColor.setStroke()
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /// 生成指定大小的不透明图象
    ///
    /// - parameter size:      尺寸
    /// - parameter backColor: 背景颜色
    ///
    /// - returns: 图像
    public func yh_image(size: CGSize? = nil, backColor: UIColor = UIColor.white) -> UIImage? {
        
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        draw(in: rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
    /// 通过颜色,转换成指定图片
    ///
    /// - Parameter color: 颜色
    /// - Returns: 图片
    public static func yh_from(color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

}

public extension UIImage {
    
    
    /// 给PNG透明图片添加自定义颜色背景
    ///
    /// - Parameter color: 颜色
    /// - Returns: 新图片
    public func yh_maskWithColor(color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        
        color.setFill()
        
        context.fill(rect)
        context.setBlendMode(.copy)
        self.draw(in: rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    
    /// 通过一组颜色生成图片
    ///
    /// - Parameters:
    ///   - colors: 颜色
    ///   - startPoint: 渐变起始点
    ///   - endPoint: 渐变结束点
    ///   - size: 大小
    /// - Returns: 图片
    public class func yh_gradient(colors : [UIColor], startPoint : CGPoint ,endPoint : CGPoint, size : CGSize) -> UIImage {
        
   
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        
        var cgColors : [CGColor] = [CGColor] ()
        for i in colors {cgColors.append(i.cgColor)}
        gradientLayer.colors = cgColors
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.isOpaque, 0);
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
        return outputImage!
    }
   
    /// 生成指定大小的图片
    ///
    /// - Parameter reSize: 拉伸大小
    /// - Returns: 返回新图片
    func yh_reSizeImage(reSize:CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(reSize,false,1)
        
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return reSizeImage
    }


}

public extension UIImage {
    
    public static func yh_image(name: String, bundleClass: AnyClass?, bundleFile: String? = nil) -> UIImage? {
        var image: UIImage?
        
        let bundle = bundleClass == nil ? Bundle.main : Bundle(for: bundleClass!)
        
        image = self.init(named: name, in: bundle, compatibleWith: nil)
        
        if image == nil, let path = bundle.path(forResource: bundleFile, ofType: "bundle") {
            image = self.init(named: name, in: Bundle.init(path: path), compatibleWith: nil)
        }
        
        if image == nil && bundleClass != nil {
            let nameSpace = NSStringFromClass(bundleClass!).components(separatedBy: ".").first
            if let nameS = nameSpace,  let path = bundle.path(forResource: nameS, ofType: "bundle"){
                image = self.init(named: name, in: Bundle.init(path: path), compatibleWith: nil)
            }
        }
        
        return image
    }
}
