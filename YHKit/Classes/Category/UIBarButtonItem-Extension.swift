//
//  UIBarButtonItem-Extension.swift
//  YHkit
//
//  Created by Arvin on 2018/4/12.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

public extension UIBarButtonItem {
    
    /// 普通, 高亮状态
    public convenience init(itemImageName : String, highlightedImage : String, target : Any, action : Selector) {
        
        let button : UIButton = UIButton ()
        button.setImage(UIImage(named: itemImageName), for: .normal)
        button.setImage(UIImage(named: highlightedImage), for: .highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let contentView : UIView = UIView(frame: button.frame)
        contentView.addSubview(button)
        self.init(customView: contentView)
    }
    
    /// 普通,选中状态
    public convenience init(itemImageName : String, selectedImage : String, target : Any, action : Selector) {
        
        let button : UIButton = UIButton ()
        button.setImage(UIImage(named: itemImageName), for: .normal)
        button.setImage(UIImage(named: selectedImage), for: .selected)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let contentView : UIView = UIView(frame: button.frame)
        contentView.addSubview(button)
        self.init(customView: contentView)
    }
}
