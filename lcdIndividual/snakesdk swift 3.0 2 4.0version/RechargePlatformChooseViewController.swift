//
//  RechargePlatformChooseViewController.swift
//  snakesdk
//
//  Created by tgame on 16/8/1.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class RechargePlatformChooseViewController: UIViewController, RechargeDelegate, WXApiDelegate, UIAlertViewDelegate {
    
    @IBOutlet weak var _lblAccount: UILabel!
    @IBOutlet weak var _lblBalance: UILabel!
    
    @IBOutlet weak var _vHeader: UIView!
    @IBOutlet weak var _vAlipay: UIView!
    @IBOutlet weak var _vUnionPay: UIView!
    @IBOutlet weak var _vWechat: UIView!
    
    @IBOutlet weak var _vBackground: UIView!
    @IBOutlet weak var _vWechatAlert: UIView!
    
   
    private let _highlightColor = [NSAttributedStringKey.foregroundColor: UIColor.orange]
    private let _normalColor = [NSAttributedStringKey.foregroundColor: UIColor.gray]
    
    //充值完成
    private var _recharged = false
    
    var context: Context!
    
    //todo: need remove ?
    private func _addGestureForViews() {
        
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vAlipay, #selector(RechargePlatformChooseViewController.handleAlipay) )
        f(_vUnionPay, #selector(RechargePlatformChooseViewController.handleUnionpay) )
        f(_vWechat, #selector(RechargePlatformChooseViewController.handleWeChat) )
        
    }
    
    private func _addBorderForViews() {
        
        let border = Border(size: 0.5, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderBottom = border
            
        }
        
        f(_vHeader)
        
    }
    
    private func _setBalance( balance: Int) {
        
        let tips = NSMutableAttributedString(string: "accountBalance".localized, attributes:  _normalColor)
        let balance = NSAttributedString(string: " \(balance)点 ", attributes:  _highlightColor)
        let rate = NSMutableAttributedString(string: "exchangeRate".localized, attributes:  _normalColor)
        
        tips.append(balance)
        tips.append(rate)
        _lblBalance.attributedText = tips
        
        
    }
    
    private func _setUIElements() {
        _addGestureForViews()
        _addBorderForViews()
        
        _lblAccount.text = context?.account
        
        _setBalance(balance: context.any as! Int)
        
        _vBackground.isHidden = true
        Meta.setBtnCornerRadius(_vWechatAlert)
    }
    
    @IBAction func onConfirmClicked(sender: UIButton) {
        _vBackground.isHidden = true
    }
    private func _presentRechargeVC() {
        Snake.sharedInstance.productions(){ /*[unowned self]*/ (productions: [Production]?, ok: Bool) -> Void in
            
            if !ok {
                return
            }
            
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "RechargeViewController") as? RechargeViewController else {
                return
            }
            
            
            vc.context = self.context
            vc.context.any = productions!
            vc.rechargeDelegate = self
            
            UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUIElements()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if _recharged {
            
            let title = "payResult".localized
            let msg = "paySuccess".localized
            let confirmTitle = "payAgain".localized
            let cancelTitle = "return".localized
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title:  confirmTitle, style: UIAlertActionStyle.default, handler: handlePayAgain))
                alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.cancel, handler: handlePayFinisehd))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let alert = UIAlertView()
                alert.title = title
                alert.message = msg
                alert.addButton(withTitle: cancelTitle)
                alert.addButton(withTitle: confirmTitle)
                alert.cancelButtonIndex=0
                alert.delegate=self;
                
                alert.show()
                
            }
            
            
        }
        
    }
    @objc func handleAlipay() {
        Payment.sharedInstance.payBy = PayBy.AliPay
        _presentRechargeVC()
        
        
    }
    @objc func handleUnionpay() {
        Payment.sharedInstance.payBy = PayBy.UnionPay
        _presentRechargeVC()
        
    }
    @objc func handleWeChat() {
        if WXApi.isWXAppInstalled() {
            Payment.sharedInstance.payBy = PayBy.WeChat
            _presentRechargeVC()
        }
        else {
            Utils.localShowToast(message: "请安装微信客户端")
        }
    }
    
    @available(iOS 8.0, *)
    func handlePayAgain(action: UIAlertAction) {}
    
    @available(iOS 8.0, *)
    func handlePayFinisehd(action: UIAlertAction) {
        self.dismiss(animated: true)
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if(buttonIndex==alertView.cancelButtonIndex){
            self.dismiss(animated: true)
        }else {
            print("placeholder")
        }
        
        
    }
    
    func recharged(balance: Int) {
        _setBalance(balance: balance)
        _recharged = true
        
    }
    
}
