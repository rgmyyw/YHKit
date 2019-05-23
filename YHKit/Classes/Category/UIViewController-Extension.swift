//
//  UIViewController-Extension.swift
//  nilhy
//
//  Created by nilhy on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    var tabbarHeight : CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 0
    }
}



