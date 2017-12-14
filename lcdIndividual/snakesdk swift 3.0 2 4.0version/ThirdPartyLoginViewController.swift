//
//  ThirdPartyLoginViewController.swift
//  snakesdk
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class ThirdPartyLoginViewController: UIViewController {

    var context: Context!
    
    @IBOutlet weak var _vWeChat: UIView!
    @IBOutlet weak var _vWeibo: UIView!
    
    
    private func _addGestureForViews(){
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vWeChat, #selector(ThirdPartyLoginViewController.handleWeChatLogin) )
        f(_vWeibo, #selector(ThirdPartyLoginViewController.handleWeiboLogin) )
    
    }
    
    @objc func handleWeChatLogin() {
        _wechatLogin()
    }
    
    @objc private func _onWechatLoginNotified( notification: NSNotification ) {
        var userInfo: Dictionary = notification.userInfo!
        let code: String = userInfo["code"] as! String
        Cache.sharedInstance.code = code
        Snake.sharedInstance.thirdPartyLogin( context: context, code: code, platform:"wechat")
    }
    
     private func _wechatLogin(){
        if WXApi.isWXAppInstalled() {
            
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo" //用户授权的作用域，使用逗号（,）分隔
            req.state = "123"
            WXApi.send(req)
        
        }else{
            _setupAlertController()
        }

    }
    
    private func _setupAlertController(){
        if #available(iOS 8.0, *) {
            let alert = UIAlertController.init(title: "tips".localized, message: "firstInstallClient".localized, preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction.init(title: "sure".localized, style: UIAlertActionStyle.default, handler: nil)
            alert .addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertView.init(title: "tips".localized, message: "firstInstallClient".localized, delegate: self, cancelButtonTitle: nil)
            
            alert.alertViewStyle = UIAlertViewStyle.default
            alert.addButton(withTitle: "sure".localized)
            alert.show()
        }
        
    
    }
    
    
    @objc func handleWeiboLogin(){
        print("handleWeiboLogin")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _addGestureForViews()
//        NotificationCenter.default.addObserver(self, selector: #selector(ThirdPartyLoginViewController._onWechatLoginNotified(notification:self)), name: NSNotification.Name(rawValue: Notification.WechatLogined, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
