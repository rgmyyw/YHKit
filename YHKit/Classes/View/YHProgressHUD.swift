//
//  YHProgressHUD.swift
//  YHKit
//
//  Created by nilhy on 2018/7/16.
//

import UIKit

private class YHCoverView: UIView {
    private var activity: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activity.center = CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.5)
    }
}

extension YHCoverView {
    private func setupUI() {
        addSubview(activity)
        activity.startAnimating()
        self.backgroundColor = UIColor.clear
        UIView.animate(withDuration: 0.4) {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        }
    }
}

extension YHCoverView {
    fileprivate func hide() {
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 0
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
}

public class YHProgressHUD {
    
    class public func showLoading(in view: UIView?) {
        let parent = view == nil ? UIApplication.shared.keyWindow : view
        guard let parentView = parent else { return }
        let coverView = YHCoverView(frame: CGRect(x: 0, y: 0, width: parentView.bounds.width, height: parentView.bounds.height))
        coverView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        parentView.addSubview(coverView);
    }
    
    class public func hideLoading(in view: UIView?) {
        let parent = view == nil ? UIApplication.shared.keyWindow : view
        guard let parentView = parent else { return }
        
        for subview in parentView.subviews {
            if subview.isMember(of: YHCoverView.self) {
                (subview as? YHCoverView)?.hide()
                break
            }
        }
    }
    
    class public func toast(_ tip: String, in view: UIView?) {
        
    }
}
