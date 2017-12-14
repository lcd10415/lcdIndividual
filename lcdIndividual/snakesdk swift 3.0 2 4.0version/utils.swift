//
//  utils.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//


import UIKit


//所有辅助api
struct Utils {
    
    //生成一个uuid
    static func UUID() -> String {
        return NSUUID().uuidString
        
    }
    
    //MARK: - Crypto
    //使用指定的公钥对进行签名
    static func sign(plain: String, derString: String ) -> String {
        do {
            return try  SnakeRSA.encryptString(str: plain, publicKeyDER: derString)
            
        } catch let err {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "utils",
                "action": "sign",
                "plain": plain,
                "derString": derString,
                "error": err,
                ])
            return  ""
        }
        
        
    }
    
    
    //md5
    static func MD5(plain : String) -> String? {
        guard let data = plain.data(using: String.Encoding.utf8) else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "utils",
                "action": "MD5",
                "plain": plain,
                "error": "not utf8 string"
                ])
            
            return nil
        }
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        data.withUnsafeBytes { bytes in
            CC_MD5(bytes, CC_LONG(data.count), &digest)
        }
        
        
        //return (0..<Int(CC_MD5_DIGEST_LENGTH)).reduce("", combine: { $0 + String(format: "%02x", digest[$1]) })
        return (0..<Int(CC_MD5_DIGEST_LENGTH)).reduce(""){ $0 + String(format: "%02x", digest[$1]) }
    }
    
    //MARK: - Network
    static func isEnableWIFI() -> Bool {
        return Meta.networkType() == "WIFI"
    }
    
    static func isEnable3G() -> Bool {
        
        return Meta.networkType() == "3G"
    }
    
    static func isEnable4G() -> Bool {
        return Meta.networkType() == "4G"
    }
    
    static func isNotReachable() -> Bool {
        return Meta.networkType() == "NotReachable"
    }
    
    //MARK: - Device metas
    static var IP :String {
        get {
            
            
            var addrs = Meta.IFAddresses()
            if addrs.count > 0 {
                        return addrs[0]
            }
            
            return ""

        }
    }
    
    //app
    static var application: String {
        get {
            return "\(Meta.bundleName()) \(Meta.bundleVersion()) "
        }
    }
    
    //操作系统
    static var OS: String {
        get {
            return "\(Meta.osName()) \(Meta.osVersion()) "
        }
    }
    
    //设备语言
    static var language: String {
        get {
            return Meta.language()
        }
    }
    
    //设备类型
    static var deviceType : String {
        get {
            return UIDevice.current.deviceType.rawValue
        }
    }
    
    //设备uuid
    static var deviceID:  String {
        get {
            return Cache.sharedInstance.deviceID
        }
    }
    
    
    //1970~2038
    static var unixTime: Int64 {
        get {
            return Int64(NSDate().timeIntervalSince1970 )
        }
        
    }
    
    
    //MARK: - users
    //是否可以自动登录
    static func canAutoLogin()-> Bool {
        let ret =  Cache.sharedInstance.currentUser != nil &&
            Cache.sharedInstance.currentToken != nil &&
            Cache.sharedInstance.currentUserType != nil
        
        return ret
        
    }
    //当前用户是否在线
    static func isOnline() -> Bool {
        return Cache.sharedInstance.currentUserType != nil
    }
    
    //清除当前用户
    static func clearCurUser() {
        Cache.sharedInstance.currentUserType = nil
        
    }
    
    //当前用户类型: guest/phone/snake ?
    static func curUserType()-> LoginBy? {
        guard let type =  Cache.sharedInstance.currentUserType else {
            return nil
        }
        return  LoginBy(rawValue: type)
        
    }
    
    
    //MARK: - task
    /**
     1. 基于原task创建一个延迟任务
     2. 投递1中创建的任务
     3. 返回一个canceler,如果需要撤销此任务,则调用此cancel
     4. 如果指定时间后,此任务未被撤销,则向main queue投递此原task
     
     5. 是否存在线程同步问题????
     */
    static func delay(time:TimeInterval, task:@escaping ()->()) ->  Canceler {
        typealias TaskCancelable = (_ cancel : Bool) -> ()

        //指定时间后投递此task
        func dispatch_later(t:@escaping ()->()){
            let deadlineTime = DispatchTime.now() + Double(Int64(time*Double(NSEC_PER_SEC)))/Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: t)
            
        }
        
        
        let originTask: ()-> Void = task
        
        let delayedTask: TaskCancelable = {
            cancel in
                if (cancel == false) {
                    DispatchQueue.main.async(execute: originTask)
                }
        }
        
        dispatch_later {
            delayedTask(false)
        }
        
        return {
            delayedTask(true)
        };
    }
    
    //MARK: - miscs
    //有跳转显示一个toast
    static func skipShowToast(message: String, duration : TimeInterval = 2.0, pos :ToastPosition = .top )->Void {
        if message.characters.count <= 0 {
            return
        }
        
        let f = {
            UIViewController.topMostViewController()?.view.makeToast(message, duration: duration, position: pos)
        }
        if !UIViewController.topMostViewController()!.isPresentedAsModal {
            f()
            return
        }
        
        if UIViewController.topMostViewController()?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController != nil {
            UIViewController.topMostViewController()?.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController!.dismiss(animated: true) {
                f()
            }
        }
        if UIViewController.topMostViewController()?.presentingViewController?.presentingViewController?.presentingViewController != nil {
            UIViewController.topMostViewController()?.presentingViewController?.presentingViewController?.presentingViewController!.dismiss(animated: true) {
                f()
            }
        }
        if UIViewController.topMostViewController()?.presentingViewController?.presentingViewController != nil {
            UIViewController.topMostViewController()?.presentingViewController?.presentingViewController!.dismiss(animated: true) {
                f()
            }
        }
        if UIViewController.topMostViewController()?.presentingViewController != nil {
            UIViewController.topMostViewController()?.dismiss(animated: true, completion: { 
                f()
            })
        }
        
    }
    
    //MARK: - miscs
    //本界面显示一个toast
    static func localShowToast(message: String, duration : TimeInterval = 2.0, pos :ToastPosition = .top )->Void {
        if message.characters.count <= 0 {
            return
        }
        UIViewController.topMostViewController()?.view.makeToast(message, duration: duration, position: pos)
       
    }
    
    
    //显示loading,在合适的地方调用返回的Closer 关闭此loading.
    static func showLoading( style: UIActivityIndicatorViewStyle = .gray) -> Closer {
        let loading = UIActivityIndicatorView(activityIndicatorStyle: style)
        loading.hidesWhenStopped = true
        
        let rootView = (UIViewController.topMostViewController()?.view)!
        
        let rootViewFrame = rootView.frame
        let loadingFrame = loading.frame
        
        let x = rootViewFrame.origin.x + rootViewFrame.size.width/2 - loadingFrame.size.width/2
        let y = rootViewFrame.origin.y + rootViewFrame.size.height/2 - loadingFrame.size.height/2
        loading.setPos(pos: CGPoint(x: x, y: y))
        rootView.addSubview(loading)
        
        loading.startAnimating()
        
        return {
            loading.stopAnimating()
            loading.removeFromSuperview()
        }
        
    }
    
    
    //设置label的颜色属性
    //texts与colors必须按序--对应(多余colors的将被忽略)
    static  func setAttributedText( lbl:UILabel, texts: [String], colors:[UIColor] = [UIColor.black, Meta.accountColor ]) {
        guard texts.count <= colors.count && texts.count > 0 else {
            return
        }
        
        let baseColor = [NSAttributedStringKey.foregroundColor:colors[0]]
        let baseText = NSMutableAttributedString(string: texts[0], attributes: baseColor)
        
        for i in 1 ..< texts.count {
            let color =  [NSAttributedStringKey.foregroundColor:colors[i]]
            let text =  NSAttributedString(string: texts[i], attributes: color)
            baseText.append(text)
        }
        
        lbl.attributedText = baseText
    }
}





