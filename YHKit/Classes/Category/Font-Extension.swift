//
//  Font-Extension.swift
//  BSGangs
//
//  Created by admin on 2017/12/13.
//

import UIKit


public extension UIFont {
    
    public class func PFR() -> String{
        return UIDevice.current.systemVersion >= "9.0" ? "PingFangSC-Regular" : "PingFangSC-Regular"
    }
    public class func PFR30Font () -> UIFont { return UIFont(name: PFR(), size: 30)! }
    public class func PFR20Font () -> UIFont { return UIFont(name: PFR(), size: 20)! }
    public class func PFR19Font () -> UIFont { return UIFont(name: PFR(), size: 19)! }
    public class func PFR18Font () -> UIFont { return UIFont(name: PFR(), size: 18)! }
    public class func PFR17Font () -> UIFont { return UIFont(name: PFR(), size: 17)! }
    public class func PFR16Font () -> UIFont { return UIFont(name: PFR(), size: 16)! }
    public class func PFR15Font () -> UIFont { return UIFont(name: PFR(), size: 15)! }
    public class func PFR14Font () -> UIFont { return UIFont(name: PFR(), size: 14)! }
    public class func PFR13Font () -> UIFont { return UIFont(name: PFR(), size: 13)! }
    public class func PFR12Font () -> UIFont { return UIFont(name: PFR(), size: 12)! }
    public class func PFR11Font () -> UIFont { return UIFont(name: PFR(), size: 11)! }
    public class func PFR10Font () -> UIFont { return UIFont(name: PFR(), size: 10)! }
}
