//
//  YHNavigationBar.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit
import SnapKit

open class YHNavigationBar: UIView {
    
    /// 导航栏底部分割线
    public let bottomSepLineView = UIView()
    /// 导航栏标题
    public let titleLabel = UILabel()
    
    /// 设置左边导航条barbuttonItem,注意，默认有返回按钮，如果直接给yh_leftBarButtonItems 赋值，默认导航按钮会被覆盖,建议使用append
    public var yh_leftBarButtonItems : [UIView] = []
    /// 设置右边导航条barbuttonItem
    public var yh_rightBarButtonItems : [UIView] = []


    private lazy var yh_navigationBarLeftView : UIView = UIView()
    private lazy var yh_navigationBarRightView : UIView = UIView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.white
        addSubview(bottomSepLineView)
        addSubview(titleLabel)
        addSubview(yh_navigationBarLeftView)
        addSubview(yh_navigationBarRightView)
        
        
        yh_navigationBarLeftView.translatesAutoresizingMaskIntoConstraints = false
        yh_navigationBarRightView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSepLineView.backgroundColor = UIColor.lightGray
        bottomSepLineView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.greaterThanOrEqualTo(40)
            make.height.equalTo(44)
            make.bottom.equalTo(bottomSepLineView.snp.top)
        }
        
        bottomSepLineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1.0 / UIScreen.main.scale)
        }
        
        yh_navigationBarLeftView.snp.makeConstraints { (make) in
            make.height.centerY.equalTo(titleLabel)
            make.left.equalTo(self)
            make.right.equalTo(titleLabel.snp.left)
        }
        
        yh_navigationBarRightView.snp.makeConstraints { (make) in
            make.height.centerY.equalTo(yh_navigationBarLeftView)
            make.right.equalTo(self)
            make.left.equalTo(titleLabel.snp.right)
        }
        
        
//        //titleLabel.backgroundColor = UIColor.yellow
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0));
//        titleLabel.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 0, constant: 44))
//        //addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.5, constant: 0))
//        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
//        bottomSepLineView.addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0, constant: 1.0 / UIScreen.main.scale))
//
//
//
//
//
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -10));
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 16))
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0));
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0));
//
//
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -16));
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 10));
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: yh_navigationBarLeftView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0));
//        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: yh_navigationBarLeftView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0));
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        var leftLastOffsetX : CGFloat  = 15
        for view in yh_leftBarButtonItems {
            view.frame = CGRect(x: leftLastOffsetX, y: 0, width: view.frame.width, height: yh_navigationBarLeftView.frame.height)
            leftLastOffsetX = view.frame.maxX
            yh_navigationBarLeftView.addSubview(view)
        }
        
        if !yh_rightBarButtonItems.isEmpty {
            
            var rightLastOffsetX : CGFloat  = yh_navigationBarRightView.bounds.width
            for view in yh_rightBarButtonItems {
                rightLastOffsetX = (rightLastOffsetX - view.frame.width)
                view.frame = CGRect(x: rightLastOffsetX, y: 0, width: view.frame.width, height: yh_navigationBarRightView.frame.height)
                yh_navigationBarRightView.addSubview(view)
            }
        }
    }
    
    
    
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override open func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        
    }
}
