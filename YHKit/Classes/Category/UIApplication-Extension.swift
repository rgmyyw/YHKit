//
//  UIApplication-Extension.swift
//  Alamofire
//
//  Created by nilhy on 2019/5/11.
//

import UIKit

public extension UIApplication {
    
    var yh_interfaceOrientation_isPortrait: Bool {
        return UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait
    }
}

