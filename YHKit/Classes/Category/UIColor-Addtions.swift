//
//  UIColor+Addtions.swift
//  SimpleSugareDemo
//
//  Created by 杨海 on 2017/5/3.
//  Copyright © 2017年 杨海. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func HexColor(_ hexColor: Int32 ) -> UIColor {
        
        let r = CGFloat(((hexColor & 0x00FF0000) >> 16)) / 255.0
        let g = CGFloat(((hexColor & 0x0000FF00) >> 8)) / 255.0
        let b = CGFloat(hexColor & 0x000000FF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

extension UIColor {
    
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}

