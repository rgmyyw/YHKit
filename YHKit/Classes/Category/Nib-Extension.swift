//
//  Nib-Extension.swift
//  MJRefresh
//
//  Created by nilhy on 2019/6/5.
//

import UIKit

public extension UIView {
    
    public static var nib : UINib {
        return UINib(nibName: "\(self)", bundle: nil)
    }
    
    public static var identifierName : String {
        return "\(self)identifierName"
    }
    
}
