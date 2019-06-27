//
//  YHNavBarViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

@objc public protocol YHNavBarViewControllerDelegate : class {
    
    /// 实现该协议,需要自己手动返回,可以拦截一些事件,或者说你要返回多层。
    @objc optional func navigationBackButtonClick ()
}

public enum YHNavBarViewControllerStyle {
    public static var preferredStatusBarStyle : UIStatusBarStyle = .default
}

open class YHNavBarViewController: UIViewController {
    
    public weak var delegate : YHNavBarViewControllerDelegate?
    
    /// 是否禁止全局滑动返回, 默认false
    public var yh_interactivePopDisabled = false
    
    /// YHKit: 是否需要隐藏返回按钮
    public var yh_isBackActionBtnHidden = false {
        willSet {
            yh_backBtn.isHidden = newValue
        }
    }

    /// YHKit: 导航返回按钮箭头图片
    public var yh_navigationBackButtonImage : UIImage? = nil {
        willSet{
            yh_backBtn.setImage(newValue, for: UIControlState.normal)
            yh_backBtn.setImage(newValue, for: UIControlState.highlighted)
        }
    }
    /// YHKit: 导航条高度
    public var yh_navigationBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height + 44.0 {
        willSet{
            heightConstraint?.constant = newValue
            updateViewConstraints()
        }
    }
    /// YHKit: 导航条
    public let yh_navigationBar: YHNavigationBar = YHNavigationBar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: UIApplication.shared.statusBarFrame.size.height + 44)))
    
    /// YHKit: 默认返回箭头
    public let yh_backBtn: UIButton = UIButton(type: UIButtonType.custom)
    
    private var heightConstraint: NSLayoutConstraint?
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        yh_addNavBar()
        yh_addBackBtn()
        navigationItem.addObserver(self, forKeyPath: "title", options: NSKeyValueObservingOptions.new, context: nil)
    }
 
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        yh_backBtn.isHidden = yh_isBackActionBtnHidden
    }
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.bringSubview(toFront: yh_navigationBar)
        self.heightConstraint?.constant = yh_navigationBarHeight
    }
    
    deinit {
        if self.isViewLoaded {
            navigationItem.removeObserver(self, forKeyPath: "title")
        }
    }
}

// MARK:- StatusBar
//        setNeedsStatusBarAppearanceUpdate()
extension YHNavBarViewController {
    
    open override var prefersStatusBarHidden: Bool {
        return false
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return  YHNavBarViewControllerStyle.preferredStatusBarStyle
    }
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    open override var shouldAutorotate: Bool {
        return false
    }
    // MARK: - about keyboard orientation
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        //return UIInterfaceOrientationMask.allButUpsideDown
        return UIInterfaceOrientationMask.portrait
    }
    //返回最优先显示的屏幕方向
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
}

// MARK:- title
extension YHNavBarViewController {
    open override var title: String? {
        didSet {
            if isViewLoaded {
                yh_navigationBar.titleLabel.text = title
            }
        }
    }
   open  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let navigationItem = object as? UINavigationItem
        if keyPath! == "title" && (navigationItem != nil) && (navigationItem! == self.navigationItem) {
            yh_navigationBar.titleLabel.text = change?[NSKeyValueChangeKey.newKey] as? String
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension YHNavBarViewController {
    private func yh_addNavBar () {

        view.addSubview(yh_navigationBar)
        yh_navigationBar.isHidden = !(parent != nil && parent!.isKind(of: YHNavigationController.self))
        yh_navigationBar.titleLabel.text = navigationItem.title ?? title
        yh_navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(item: yh_navigationBar, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 0, constant: yh_navigationBarHeight)
        yh_navigationBar.addConstraint(heightConstraint)
        self.heightConstraint = heightConstraint
        view.addConstraint(NSLayoutConstraint(item: yh_navigationBar, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: yh_navigationBar, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: yh_navigationBar, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
    }
    private func yh_addBackBtn() {
        
        yh_backBtn.setImage(yh_navigationBackButtonImage, for: UIControlState.normal)
        yh_backBtn.setImage(yh_navigationBackButtonImage, for: UIControlState.highlighted)
        yh_backBtn.frame = CGRect(x: 10, y: UIApplication.shared.statusBarFrame.size.height, width: 34.0, height: 44.0)
        yh_backBtn.addTarget(self, action: #selector(yh_backBtnClick(btn:)), for: UIControlEvents.touchUpInside)
        
        yh_navigationBar.yh_leftBarButtonItems.append(yh_backBtn)
    }
    @objc open func yh_backBtnClick(btn: UIButton) {
        
        if let backCallBack = delegate?.navigationBackButtonClick {
            backCallBack()
            return
        }
        
        if (navigationController?.presentedViewController != nil || navigationController?.presentingViewController != nil) && navigationController?.childViewControllers.count == 1 {
            dismiss(animated: true, completion: nil)
        }else if let navVc = navigationController {
            if navVc.childViewControllers.count > 1 {
                navVc.popViewController(animated: true)
            }
        }else if (presentationController != nil || presentedViewController != nil) {
            dismiss(animated: true, completion: nil)
        }
    }
}

