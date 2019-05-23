//
//  YHCollectionViewController.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//  Copyright © 2018年 nilhy. All rights reserved.
//

import UIKit

open class YHCollectionViewController: YHViewController {
    
    @IBOutlet public var collectionView: UICollectionView!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        if collectionView == nil {
            addCollectionView()
        }
        setupCollectionView()
    }
}

extension YHCollectionViewController {
    private func setupCollectionView () {
        if #available(iOS 11, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        }
        if (parent != nil) && parent!.isKind(of: UINavigationController.self) {
            var contentInset = collectionView!.contentInset
            contentInset.top += yh_navigationBar.frame.size.height
            collectionView?.contentInset = contentInset
        }
        
        collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView?.backgroundColor = self.view.backgroundColor;
        collectionView?.dataSource = self;
        collectionView?.delegate = self;
    }
    private func addCollectionView () {
        collectionView = YHCollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView!)
    }
}

extension YHCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    open  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        view.endEditing(true)
    }
    open  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
