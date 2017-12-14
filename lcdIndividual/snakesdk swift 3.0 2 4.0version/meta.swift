 //
//  meta.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit
import CoreTelephony

//设备的meta信息
struct Meta {
    
    //全局常量
    static let screenW = UIScreen.main.bounds.size.width
    static let screenH = UIScreen.main.bounds.size.height
   
    //选中的button的颜色
    static let selectedBgColor = UIColor.init(red: 238/255.0, green: 112/255.0, blue: 69/255.0, alpha: 1)
    
    //logo绿色
    static let logoGreenColor = UIColor.init(red: 66/255.0, green: 182/255.0, blue: 180/255.0, alpha: 1)
    
    //边框颜色
    static let borderColor = UIColor.init(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1)
    
    //账号字体颜色
    static let accountColor = UIColor.init(red: 0, green: 135/255.0, blue: 1, alpha: 1)
    
    //设置textfield左边的imageView图片
    static let addLeftImageView = { /*[unowned self]*/ (view: UITextField, imgName: String,with: CGFloat) in
        
        guard let img =  UIImage( named: imgName ) else {
            let leftView = UIView(frame: CGRect(x:0, y:0, width:with, height:view.bounds.size.height))
            view.leftView = leftView
            view.leftViewMode = UITextFieldViewMode.always
            return
        }
        
        let leftImage =  UIImageView(frame: CGRect(x:0, y:0, width:img.size.width, height:img.size.height))
        leftImage.image = img
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: with, height:view.bounds.size.height))
        leftImage.center = leftView.center
        leftImage.contentMode = .scaleAspectFit
        leftView.addSubview(leftImage)
        view.leftView = leftView
        view.leftViewMode = UITextFieldViewMode.always
    }
    //设置边框颜色
    static let setBoderColor = { (v: UITextField,Color:UIColor) in
        v.layer.borderColor = Color.cgColor
        v.layer.borderWidth = 1.0
        v.layer.masksToBounds = true
    }

    //设置按钮圆角
    static let setBtnCornerRadius = {(v: UIView) in
        v.layer.masksToBounds = true
        v.layer.cornerRadius = Constant.BtnCornerRadius
    }
    
    static func bundleVersion() -> String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
    }
    
    static func bundleID() -> String {
        return  Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    static func bundleName() -> String {
        return  Bundle.main.infoDictionary!["CFBundleName"] as! String
    }

    
//    dict["lang"] = NSLocale.preferredLanguages()[0]
//    if let infodict = NSBundle.mainBundle().infoDictionary {
//        if let appname = infodict["CFBundleName"] as? String {
//            dict["appname"] = appname
//        }
//        if let appname = infodict["CFBundleVersion"] as? String {
//            dict["appversion"] = appname
//        }
//    }

    
    //设备语言
    static func language() ->String {
        return Locale.preferredLanguages[0]
    }
    //设备型号
    static func deviceModel() -> String {
        return UIDevice.current.model
    }
    
    //os版本号
    static func osVersion() -> String {      
        return UIDevice.current.systemVersion
    }
    
    static func osName() -> String {
        return UIDevice.current.systemName
    }
    
    
    //设备uuid
    static func deviceUUID() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    //运营商名
    static func CarrierName() -> String {
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider else {
            return  "WIFI"
        }
        
        return carrier.carrierName!
        
    }
    
    //网络类型: 3g, 4g ....
    static func networkType()->String {
//        
//        do {
//            let reachability:Reachability = try Reachability.reachabilityForInternetConnection()
//            
//            try reachability.startNotifier()
//            let status = reachability.currentReachabilityStatus
//            if status == .NotReachable {
//                return "NotReachable"
//            }
//            
//            if status == .ReachableViaWiFi {
//                return "WIFI"
//            }
//            
//            if status == .ReachableViaWWAN {
//                let networkInfo = CTTelephonyNetworkInfo()
//                let carrierType = networkInfo.currentRadioAccessTechnology
//                
//                switch carrierType{
//                case CTRadioAccessTechnologyGPRS?,
//                     CTRadioAccessTechnologyEdge?,
//                     CTRadioAccessTechnologyCDMA1x?:
//                    return "2G"
//                    
//                case CTRadioAccessTechnologyWCDMA?,
//                     CTRadioAccessTechnologyHSDPA?,
//                     CTRadioAccessTechnologyHSUPA?,
//                     CTRadioAccessTechnologyCDMAEVDORev0?,
//                     CTRadioAccessTechnologyCDMAEVDORevA?,
//                     CTRadioAccessTechnologyCDMAEVDORevB?,
//                     CTRadioAccessTechnologyeHRPD?:
//                    return "3G"
//                    
//                case CTRadioAccessTechnologyLTE?:
//                    return "4G"
//                    
//                default:
//                    return ""
//                } // end of switch carrierType{
//                
//                
//            } // end of if status == .ReachableViaWWAN {
//            
//            return ""
//            
//        }catch{
//            return ""
//        }
        return ""
        
    }
    
    //ip
    static func IFAddresses() -> [String] {
        
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let flags = Int32((ptr?.pointee.ifa_flags)!)
                var addr = ptr?.pointee.ifa_addr.pointee
                
                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr?.sa_family == UInt8(AF_INET) || addr?.sa_family == UInt8(AF_INET6) {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr!, socklen_t((addr?.sa_len)!), &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address :String = String(cString: hostname){
                                addresses.append(address)
                                
                            }
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return addresses
    }
    
    //screen 尺寸
    static func screenBounds () ->CGRect{
        return  UIScreen.main.bounds
    }
    
    //1x, 2x, 3x...
    static func screenScale() -> Int {
        return Int(UIScreen.main.scale)
    }
    
    
}
