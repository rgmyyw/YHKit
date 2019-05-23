//
//  YHRefreshTableViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

open class YHRefreshTableViewController: YHTableViewController {
    
    public var viewDidLoadBeginRefreshing : Bool = true
    public var page : Int = 0
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header = YHRefreshNormalHeader(refreshingBlock: {[weak self] () -> Void in
            if let strongSelf = self {
                strongSelf.refreshing(isMore: false)
            }
        })
        tableView.mj_footer = YHRefreshAutoNormalFooter(refreshingBlock: {[weak self] () -> Void in
            if let strongSelf = self {
                strongSelf.refreshing(isMore: true)
            }
        })
        if viewDidLoadBeginRefreshing == true {
            tableView.mj_header.beginRefreshing()
        }
        
    }
    open func loadData(isMore: Bool) {
        
    }
}

extension YHRefreshTableViewController {
    private func refreshing(isMore: Bool) {
        if isMore {
            if tableView.mj_header.isRefreshing {
                if tableView.mj_footer.isRefreshing {
                    tableView.mj_footer.endRefreshing()
                }
                return
            }
            
            if tableView.mj_footer.isHidden {
                if tableView.mj_footer.isRefreshing {
                    tableView.mj_footer.endRefreshing()
                }
                return;
            }
            
            tableView.mj_header.isHidden = true
            tableView.mj_footer.isHidden = false
            
        } else {
            if tableView.mj_footer.isRefreshing {
                if tableView.mj_header.isRefreshing {
                    tableView.mj_header.endRefreshing()
                }
                return
            }
            
            if tableView.mj_header.isHidden {
                if tableView.mj_header.isRefreshing {
                    tableView.mj_header.endRefreshing()
                }
                return;
            }
            
            tableView.mj_header.isHidden = false
            tableView.mj_footer.isHidden = true
        }
        self.loadData(isMore: isMore)
    }
}

extension YHRefreshTableViewController {
    // 子类需要调用调用
    public func endHeaderFooterRefreshing() {
        if tableView.mj_header.isRefreshing {
            tableView.mj_header.endRefreshing()
        }
        if tableView.mj_footer.isRefreshing {
            tableView.mj_footer.endRefreshing()
        }
        tableView.mj_header.isHidden = false
    }
}

extension YHRefreshTableViewController {
    open override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        super.scrollViewWillBeginDragging(scrollView)
        var contentInset = scrollView.contentInset
        contentInset.bottom -= scrollView.mj_footer.frame.size.height
        scrollView.scrollIndicatorInsets = contentInset
    }
}

class YHTableView: UITableView {
    override func reloadData() {
        super.reloadData()
        for section in 0..<self.numberOfSections {
            if self.numberOfRows(inSection: section) > 0 {
                self.mj_footer?.isHidden = false
                break
            }
        }
    }
}

