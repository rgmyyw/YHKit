//
//  YHViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

open class YHViewController: YHNavBarViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        automaticallyAdjustsScrollViewInsets = false
    }
    deinit {
        print("deinit-\(self)")
    }
}
