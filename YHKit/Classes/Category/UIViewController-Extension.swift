//
//  UIViewController-Extension.swift
//  nilhy
//
//  Created by nilhy on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public var tabbarHeight : CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
    
}

public extension UIViewController {
    
    public static func topViewController(_ viewController: UIViewController? = nil) -> UIViewController? {
        
        let viewController = viewController ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = viewController as? UINavigationController,
            !navigationController.viewControllers.isEmpty
        {
            return self.topViewController(navigationController.viewControllers.last)
            
        } else if let tabBarController = viewController as? UITabBarController,
            let selectedController = tabBarController.selectedViewController
        {
            return self.topViewController(selectedController)
            
        } else if let presentedController = viewController?.presentedViewController {
            return self.topViewController(presentedController)
            
        }
        
        return viewController
    }
}



