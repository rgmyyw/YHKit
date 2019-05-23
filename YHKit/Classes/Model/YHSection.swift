//
//  YHSection.swift
//  YHKit
//
//  Created by nilhy on 2018/10/17.
//

import Foundation

public struct YHItem {
    
   public var image: Any?
   public var title: String?
   public var subTitle: String?
   public var height: CGFloat = 50
   public var operation: ((_ indexPath: IndexPath, _ gropu: YHGroup) -> ())?
   public init(image: Any? = nil, title: String?, subTitle: String? = nil, height: CGFloat = 50, operation: ((_ indexPath: IndexPath, _ gropu: YHGroup) -> ())? = nil) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.height = height
        self.operation = operation
    }
}

public struct YHSection {
    
   public var headerTitle: String?
   public var footerTitle: String?
   public var items: [YHItem] = [YHItem]()
   public init(headerTitle: String?, footerTitle: String?) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}

public struct YHGroup {
   public var sections: [YHSection] = [YHSection]()
}
