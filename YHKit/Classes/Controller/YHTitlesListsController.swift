//
//  YHTitlesScrollViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/7/7.
//

import UIKit

protocol YHTitlesListsControllerProtocol {
    func yh_addChildControllers() -> Void
}

open class YHTitlesListsController: YHViewController, YHTitlesListsControllerProtocol {
    
    public var titleScrollView = UIScrollView()
    public var titleBtns = [UIButton]()
    public var scrollView = UIScrollView()
    
    open var titleBtnNormalColor: UIColor {
        return UIColor.green
    }
    open var titleBtnSelectedColor: UIColor {
        return UIColor.lightGray
    }
    open var titleBtnFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    open var firstShowIndex: Int {
        return 0
    }
    open var contentViewY: Double {
        return 0.0
    }
    open var contentViewSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        yh_interactivePopDisabled = true
        
        yh_setup2ScrollViews()
        
        yh_addChildControllers()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(self.childViewControllers.count), height: 1.0);
        
        yh_addBtns()
        
        selectedIndex(index: firstShowIndex)
    }
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.insertSubview(scrollView, at: 0)
    }
    
    private func yh_setup2ScrollViews() {
        view.addSubview(titleScrollView)
        view.addSubview(scrollView)
        
        titleScrollView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 30))
        scrollView.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.alwaysBounceHorizontal = true
        if #available(iOS 11, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        }
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.showsHorizontalScrollIndicator = false
        titleScrollView.alwaysBounceHorizontal = false
        titleScrollView.alwaysBounceVertical = false
        if #available(iOS 11, *) {
            titleScrollView.contentInsetAdjustmentBehavior = .never
        }
        titleScrollView.contentInset = UIEdgeInsets.zero
        titleScrollView.isPagingEnabled = false
    }
    
    open func yh_addChildControllers() {
        assert(true, "子类需要实现")
    }
    
    private func yh_addBtns() {
        
        for vc in self.childViewControllers {
            let btn = UIButton(type: UIButtonType.custom)
            titleScrollView.addSubview(btn)
            btn.setTitle(vc.title ?? vc.navigationItem.title, for: UIControlState.normal)
            btn.setTitleColor(titleBtnNormalColor, for: .normal)
            btn.setTitleColor(titleBtnSelectedColor, for: .disabled)
            btn.titleLabel?.font = titleBtnFont
            btn.sizeToFit()
            btn.frame = CGRect(x: (titleBtns.last?.frame.maxX ?? 0) + 10, y: 0, width: btn.frame.width, height: 30)
            btn.tag = titleBtns.count
            btn.addTarget(self, action: #selector(btnTap(btn:)), for: .touchUpInside)
            titleBtns.append(btn)
        }
        titleScrollView.contentSize = CGSize(width: (titleBtns.last?.frame.maxX ?? 0) + 10, height: 1)
    }
    
}

extension YHTitlesListsController {
    @objc func btnTap(btn: UIButton) {
        self.selectedIndex(index: btn.tag)
    }
    private func selectedIndex(index: Int) {
        if index >= titleBtns.count {
            return
        }
        for btn in titleBtns {
            btn.isEnabled = true
        }
        titleBtns[index].isEnabled = false
        
        var contentScrollViewContentOffset = self.scrollView.contentOffset;
        contentScrollViewContentOffset.x = CGFloat(index) * UIScreen.main.bounds.width;
        
        self.scrollView.contentOffset = contentScrollViewContentOffset;
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
}


extension YHTitlesListsController: UIScrollViewDelegate {
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int( (scrollView.contentOffset.x / UIScreen.main.bounds.width) + 0.2 )
        let vc = self.childViewControllers[index]
        if vc.isViewLoaded {
            vc.viewDidAppear(false)
        }
        if vc.view.superview != nil {
            return
        }
        
        vc.view.frame = CGRect(origin: CGPoint(x: Double(index) * Double(UIScreen.main.bounds.width), y: contentViewY), size: contentViewSize)
        scrollView.addSubview(vc.view)
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.selectedIndex(index: Int( (scrollView.contentOffset.x / UIScreen.main.bounds.width) + 0.2 ))
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        if offsetX < 0 {
            return
        }
        
        let selecteIndex = Int((scrollView.contentOffset.x / UIScreen.main.bounds.width) + 0.5)
        
        if selecteIndex >= titleBtns.count {
            return
        }
        
        for btn in titleBtns {
            btn.isEnabled = true
        }
        titleBtns[selecteIndex].isEnabled = false
        
        let titleScrollViewOffsetX = titleBtns[selecteIndex].center.x - UIScreen.main.bounds.width * 0.5
        
        if titleScrollViewOffsetX <= 0  {
            
            titleScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            
        }else if titleScrollViewOffsetX >= titleScrollView.contentSize.width - UIScreen.main.bounds.width {
            
            titleScrollView.setContentOffset(CGPoint(x: titleScrollView.contentSize.width - UIScreen.main.bounds.width, y: 0), animated: true)
            
        }else {
            
            titleScrollView.setContentOffset(CGPoint(x: titleScrollViewOffsetX, y: 0), animated: true)
        }
    }
}







