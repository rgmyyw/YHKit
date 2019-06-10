//
//  NibLoadable.swift
//  Demo
//
//  Created by nilhy on 2019/4/14.
//  Copyright © 2019年 nilhy. All rights reserved.
//

import UIKit

public protocol NibLoadable {
    
}

public extension NibLoadable where Self : UIView{
    
    static func loadNibFromXib(_ nibName : String? = nil) -> Self {
        let nibName : String = nibName ?? "\(self)"
        return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! Self
    }
}
