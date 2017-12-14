//
//  AccountManagementViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/25.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class AccountManagementViewController: UIViewController {
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblTips: UILabel!
    
    //更换手机
    @IBOutlet weak var _vPhone: UIView!
    @IBOutlet weak var _lblPhone: UILabel!
    
    //设置、修改密码
    @IBOutlet weak var _vPassword: UIView!
    @IBOutlet weak var _lblPassword: UILabel!
    
    //账号类型
    @IBOutlet weak var _imgAccountType: UIImageView!
    
    var  context: Context!
    
    weak var nameObserver: NSObjectProtocol?
    
    @objc func handlePassword() {
        
        if Utils.curUserType() == .Snake {
            _passwordChangeForSnake()
            return
        }
        
        if _lblPassword.text == "passwordSet".localized {
            context.any  = PhoneStatus.noPassword
        }
        if _lblPassword.text == "passwordChange".localized {
            context.any = PhoneStatus.havePassword
        }
        
        let phoneStatus = context.any as! PhoneStatus
        if phoneStatus ==  PhoneStatus.noPassword {
            _passwordSetForPhone()
            return
        }
        else{
            _passwordChangeForPhone()
        }
       

    }
    //修改手机号
    @objc func handlePhone() {
       
        if Utils.curUserType() == .Phone {
            //账号即是手机号
            context.phone = context.account
            _presentCurrentPhoneVCBy(phoneNumber: context.phone, type: .Phone)
            
        } else {
            Snake.sharedInstance.queryUserInfo(context: context) { [unowned self] (markedPhone: String?, ok: Bool)  in
                if !ok {
                    return
                }
                //获取绑定的手机号码
                self._presentCurrentPhoneVCBy(phoneNumber: markedPhone,type: .Name)
                
            }
        }
    }
    private func _presentCurrentPhoneVCBy(phoneNumber:String?,type:VerifyCodeBy){
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "CurrentPhoneViewController") as? CurrentPhoneViewController else {
            return
        }
        
        self.context.phone = phoneNumber
        self.context.any = type
        vc.context = self.context
          UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
    }
    //todo: need remove ?
    private func _addGestureForViews() {
        
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vPhone, #selector(AccountManagementViewController.handlePhone ) )
        f(_vPassword, #selector(AccountManagementViewController.handlePassword) )
        
        
    }
    
    private func _addBorderForViews() {
        
        let border = Border(size: 1, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderTop = border
            v.borderBottom = border
            v.borderLeft = border
            
        }
        
        f(_vPassword)
        f(_vPhone)
        
        //补上最后一根竖线
        _vPhone.borderRight = border
        
        
    }
    
    //手机账号字符串截取
    private func _modifyPhoneString() -> String{
        let phoneText:NSString = _lblTips.text! as NSString
        let rightRange : NSRange = NSMakeRange(3, 11)
      
        
        var str:String = phoneText.substring(with: rightRange)
        //http://stackoverflow.com/questions/24044851/how-do-you-use-string-substringwithrange-or-how-do-ranges-work-in-swift
        let centreRange = str.index(str.startIndex, offsetBy: 3)..<str.index(str.startIndex, offsetBy: 7)
         str.replaceSubrange(centreRange, with: "****")
            return str
    }
    
    //手机账号修改密码
    private func _passwordChangeForPhone() {
        
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "ForgotenAccountVerifyCodeFillViewController") as? ForgotenAccountVerifyCodeFillViewController else {
            return
        }
        

        self.context.any = VerifyCodeBy.Phone
        
       
        //账号即是手机号
        self.context.account = self.context.phone
        self.context.phone = self._modifyPhoneString()
        
        
        vc.titleStr = "passwordChange".localized
        vc.context = self.context
        vc.modifyInfo = ModifyInfo.PasswordModify
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
    }
    
    //贪玩蛇账号修改密码
    private func _passwordChangeForSnake() {
 
        Snake.sharedInstance.queryUserInfo( context: context) {  [unowned self] (markedPhone: String?, ok: Bool)->Void  in
            if !ok {
                return
            }
            
            self.context.phone = markedPhone
            self.context.any = VerifyCodeBy.Name
            
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "ForgotenAccountVerifyCodeFillViewController") as? ForgotenAccountVerifyCodeFillViewController else {
                return
            }
            vc.titleStr = "passwordChange".localized
            vc.context = self.context
            vc.modifyInfo = .PasswordModify
            
            self.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    //手机账号设置密码
    private func _passwordSetForPhone() {
        
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PasswordSetPhoneFillViewController") as? PasswordSetPhoneFillViewController else {
            return
        }
        //账号即是手机号
        self.context.account = self.context.phone
        vc.context = self.context
        if #available(iOS 8.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            vc.modalPresentationStyle = .currentContext
        }
        UIViewController.topMostViewController()!.definesPresentationContext = true
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
    }
    private func _setUIElements() {
        
        
        var tips: String
        var titles: String
        var img: UIImage?
        var phoneStatus: PhoneStatus?
        
 
        var password = "passwordChange".localized
        
        if Utils.curUserType() == .Phone {
            titles = "phone".localized
            tips = "\("phone".localized): \((context?.account)!)"
            phoneStatus = context.any as? PhoneStatus
            img = UIImage(named: "lkt0wer_snake_phone_account_manage_.png")

            
        } else {
            titles = "account".localized
            tips = "\("account".localized): \((context?.account)!)"
            img = UIImage(named: "lkt0wer_usercenter_channel.png")
        }
        
        _lblTips.text = tips
        _imgAccountType.image = img
        
        Utils.setAttributedText(lbl: _lblTips, texts: [titles,(context?.account)!])
        
        if phoneStatus == PhoneStatus.noPassword {
            password = "passwordSet".localized
            
        }
        _lblPassword.text = password
        
        _addGestureForViews()
        _addBorderForViews()
        
        
    }
    
    private func _addObserverForName(){
        if Utils.curUserType() == .Phone {
            nameObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Notification.PhoneNumberChanged), object: nil, queue: OperationQueue.main) { [unowned self](info) in
                self._lblTips.text = "phone".localized + ((info.userInfo!["text"])! as! String)
                //账号就是手机号
                self.context.account = info.userInfo!["text"] as? String
                self.context.phone = info.userInfo!["text"] as? String
                
                Utils.setAttributedText(lbl: self._lblTips, texts: ["phone".localized, info.userInfo!["text"] as! String])
            }
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _setUIElements()
        _addObserverForName()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        if let nameObserver = nameObserver {
             NotificationCenter.default.removeObserver(nameObserver)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
