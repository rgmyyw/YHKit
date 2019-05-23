//
//  Bundle-Extension.swift
//  YHKit
//
//  Created by nilhy on 2018/10/30.
//

import Foundation

public extension Bundle {
    
    public static func yh_curBundle(class bundleOfClass: AnyClass?, bundleFile: String? = nil) -> Bundle {
        
        var bundle = bundleOfClass == nil ? Bundle.main : Bundle(for: bundleOfClass!)
        if let path = bundle.path(forResource: bundleFile, ofType: "bundle") {
            if let newBundle = Bundle.init(path: path) {
                bundle = newBundle
            }
        }
        return bundle
    }
}
