//
//  ViewController.swift
//  YHKit
//
//  Created by nilhy on 05/23/2019.
//  Copyright (c) 2019 nilhy. All rights reserved.
//

import UIKit
import YHKit

class ViewController: YHViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        yh_navigationBar.titleLabel.text = "YHKit"
        view.enableDebug = true
        
        let button = UIButton(title: "第一个", target: self, action: #selector(test))
        /// 默认有一个返回不喜欢可以直接替换
        //yh_navigationBar.yh_leftBarButtonItems.append(button)
        yh_navigationBar.yh_leftBarButtonItems = [button]
        
        let button2 = UIButton(title: "第二个", target: self, action: #selector(test))
        button2.frame.size.width = 80
        yh_navigationBar.yh_leftBarButtonItems.append(button2)
        
        let button3 = UIButton(title: "第三个", target: self, action: #selector(test))
        button3.frame.size.width = 60
        yh_navigationBar.yh_rightBarButtonItems.append(button3)
        
    }

    @objc func test() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

