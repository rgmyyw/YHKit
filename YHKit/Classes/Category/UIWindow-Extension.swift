//
//  UIWindow-Extension.swift
//  GuangYin
//
//  Created by nilhy on 2018/6/7.
//  Copyright © 2018 nilhy. All rights reserved.
//

import UIKit

public extension UIWindow {
    
    /// 递归找最上面的viewController
    public func topViewController() -> UIViewController? {
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    /// 找到当前显示的window
    private func getCurrentWindow() -> UIWindow? {
        
        // 找到当前显示的UIWindow
        var window: UIWindow? = UIApplication.shared.keyWindow
        /**
         window有一个属性：windowLevel
         当 windowLevel == UIWindowLevelNormal 的时候，表示这个window是当前屏幕正在显示的window
         */
        if window?.windowLevel != UIWindowLevelNormal {
            for tempWindow in UIApplication.shared.windows {
                if tempWindow.windowLevel == UIWindowLevelNormal {
                    window = tempWindow
                    break
                }
            }
        }
        return window
    }
    
    private func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
        
        if viewController == nil {
            return nil
        }
        
        if viewController?.presentedViewController != nil {
            
            return self.topViewControllerWithRootViewController(viewController: viewController?.presentedViewController!)
        }
        else if viewController?.isKind(of: UITabBarController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UITabBarController).selectedViewController)
        }
        else if viewController?.isKind(of: UINavigationController.self) == true {
            
            return self.topViewControllerWithRootViewController(viewController: (viewController as! UINavigationController).visibleViewController)
        }
        else {
            
            return viewController
        }
    }
    
}

extension UIWindow {
    
    public convenience init(viewController: UIViewController, backgroundColor: UIColor) {
        self.init(frame: UIScreen.main.bounds)
        self.rootViewController = viewController
        self.backgroundColor = backgroundColor
        self.makeKeyAndVisible()
    }
}
