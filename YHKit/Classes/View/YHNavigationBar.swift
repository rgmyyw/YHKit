//
//  YHNavigationBar.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit



open class YHNavigationBar: UIView {
    
    /// 导航栏底部分割线
    public let bottomSepLineView = UIView()
    /// 导航栏标题
    public let titleLabel = UILabel()
    
    /// 设置左边导航条barbuttonItem
    public var yh_leftBarButtonItems : [UIView] = []{
        didSet{
            var lastOffsetX : CGFloat  = 0
            for view in yh_leftBarButtonItems{
                view.frame = CGRect(x: lastOffsetX, y: 0, width: view.frame.width, height: yh_navigationBarLeftView.frame.height)
                lastOffsetX = view.frame.maxX
                yh_navigationBarLeftView.addSubview(view)
            }
        }
    }
    /// 设置右边导航条barbuttonItem
    public var yh_rightBarButtonItems : [UIView] = [] {
        didSet{
            var lastOffsetX : CGFloat  = yh_navigationBarRightView.bounds.width
            for view in yh_leftBarButtonItems{
                lastOffsetX = (lastOffsetX - view.frame.width)
                view.frame = CGRect(x: lastOffsetX, y: 0, width: view.frame.width, height: yh_navigationBarLeftView.frame.height)
                view.center.y = yh_navigationBarLeftView.center.y
                yh_navigationBarLeftView.addSubview(view)
            }
        }
    }


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
        
        yh_navigationBarLeftView.backgroundColor = UIColor.random()
        yh_navigationBarRightView.backgroundColor = UIColor.random()
        
        yh_navigationBarLeftView.translatesAutoresizingMaskIntoConstraints = false
        yh_navigationBarRightView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomSepLineView.backgroundColor = UIColor.lightGray
        bottomSepLineView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //titleLabel.backgroundColor = UIColor.yellow
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0));
        titleLabel.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.width, multiplier: 0, constant: 44))
        //addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.width, multiplier: 0.5, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        bottomSepLineView.addConstraint(NSLayoutConstraint(item: bottomSepLineView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 0, constant: 1.0 / UIScreen.main.scale))
        

        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: -10));
        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0));
        addConstraint(NSLayoutConstraint(item: yh_navigationBarLeftView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0));
        
        
        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.right, multiplier: 1, constant: -16));
        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 10));
        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: yh_navigationBarLeftView, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0));
        addConstraint(NSLayoutConstraint(item: yh_navigationBarRightView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: yh_navigationBarLeftView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0));
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
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
