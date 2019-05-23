//
//  UINavigationController-Extension.swift
//  Alamofire
//
//  Created by nilhy on 2019/5/11.
//

import UIKit

extension UINavigationController {
    
    /// 导航,返回N层
    ///
    /// - Parameters:
    ///   - level: 等级
    ///   - animated:
    public func yh_popToViewController(level : Int, animated: Bool) {
        
        self.popToViewController(self.viewControllers[self.viewControllers.count - (level + 1)], animated: animated)
    }
}
