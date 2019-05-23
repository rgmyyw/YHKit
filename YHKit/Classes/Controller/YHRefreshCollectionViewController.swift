//
//  YHRefreshCollectionViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit


open class YHRefreshCollectionViewController: YHCollectionViewController {
    
    //public var collectionViewHeaderRefreshingCallBack : CallBackClosure?
    //public var collectionViewFooterRefreshingCallBack : CallBackClosure?
    public var viewDidLoadBeginRefreshing : Bool = true
    public var page : Int = 0
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.mj_header = YHRefreshNormalHeader(refreshingBlock: {[weak self] () -> Void in
            
//            if let callback = self?.collectionViewHeaderRefreshingCallBack {
//                callback()
//            }
            if let strongSelf = self {
                strongSelf.refreshing(isMore: false)
            }
        })
        collectionView.mj_footer = YHRefreshAutoNormalFooter(refreshingBlock: {[weak self] () -> Void in
//            if let callback = self?.collectionViewFooterRefreshingCallBack {
//                callback()
//            }
            if let strongSelf = self {
                strongSelf.refreshing(isMore: true)
            }
        })
        
        if viewDidLoadBeginRefreshing == true {
            collectionView.mj_header.beginRefreshing()
        }
        
    }
    open func loadData(isMore: Bool) {
        
    }
}

extension YHRefreshCollectionViewController {
    private func refreshing(isMore: Bool) {
        if isMore {
            if collectionView.mj_header.isRefreshing {
                if collectionView.mj_footer.isRefreshing {
                    collectionView.mj_footer.endRefreshing()
                }
                return
            }
            
            if collectionView.mj_footer.isHidden {
                if collectionView.mj_footer.isRefreshing {
                    collectionView.mj_footer.endRefreshing()
                }
                return;
            }
            
            collectionView.mj_header.isHidden = true
            collectionView.mj_footer.isHidden = false
            
        } else {
            if collectionView.mj_footer.isRefreshing {
                if collectionView.mj_header.isRefreshing {
                    collectionView.mj_header.endRefreshing()
                }
                return
            }
            
            if collectionView.mj_header.isHidden {
                if collectionView.mj_header.isRefreshing {
                    collectionView.mj_header.endRefreshing()
                }
                return;
            }
            
            collectionView.mj_header.isHidden = false
            collectionView.mj_footer.isHidden = true
        }
        self.loadData(isMore: isMore)
    }
}


extension YHRefreshCollectionViewController {
    // 子类需要调用调用
    public func endHeaderFooterRefreshing() {
        if collectionView.mj_header.isRefreshing {
            collectionView.mj_header.endRefreshing()
        }
        if collectionView.mj_footer.isRefreshing {
            collectionView.mj_footer.endRefreshing()
        }
        collectionView.mj_header.isHidden = false
    }
}

extension YHRefreshCollectionViewController {
    open override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        super.scrollViewWillBeginDragging(scrollView)
        var contentInset = scrollView.contentInset
        contentInset.bottom -= scrollView.mj_footer.frame.size.height
        scrollView.scrollIndicatorInsets = contentInset
    }
}

class YHCollectionView: UICollectionView {
    override func reloadData() {
        super.reloadData()
        for section in 0..<self.numberOfSections {
            if self.numberOfItems(inSection: section) > 0 {
                self.mj_footer?.isHidden = false
                break
            }
        }
    }
}
