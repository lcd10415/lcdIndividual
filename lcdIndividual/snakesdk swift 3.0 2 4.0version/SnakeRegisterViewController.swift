//
//  SnakeRegisterViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/13.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit



class SnakeRegisterViewController: UIViewController, UITextFieldDelegate{
    
    enum RegisterCond : Int {
        case Account
        case Pass
        case Captcha
        case Law
        
        case CheckPassed = 15 // ( 1<<3 | 1 << 2 | 1 << 1 | 1 << 0 )
    }
    
    
    @IBOutlet weak var _txtAccount: UITextField!
    @IBOutlet weak var _txtPass: UITextField!
    @IBOutlet weak var _txtCaptcha: UITextField!
    
    @IBOutlet weak var _btnPassToggle: UIButton!
    @IBOutlet weak var _btnRegister: UIButton!
    @IBOutlet weak var _btnService: UIButton!
    @IBOutlet weak var _btnPrivate: UIButton!
    
    @IBOutlet weak var _vCaptcha: UIImageView!
    @IBOutlet weak var _vLawChecker: UIImageView!
    
    @IBOutlet weak var _lblLaw: UILabel!

    //提示
    @IBOutlet weak var _lblAccountTips: UILabel!
    @IBOutlet weak var _lblPasswordTips: UILabel!
    @IBOutlet weak var _lblVerifyCodeTips: UILabel!
    
    var context: Context!
    
    private var _isLawChecked = true
    ///注册需要满足的条件bitset
    private var _regCondBitset = 1 << RegisterCond.Law.rawValue  //默认协议勾选
    
    //captcha在服务器上的id
    private var _verifyID : String?
    
    //背景
    private var _vBg:UIView!
    private var _lblHeader: UILabel!
    
    @IBAction func onTextChanged(_ sender: UITextField) {
        
        let obj = sender 
        let len = obj.text?.characters.count
        
        let f = { ( min: Int , max: Int) -> Bool in
            if len! >= min && len! <= max {
                return true
            }
            return false
        }
        
        var isSetVal = true
        var bitIndex = 0
        
        switch obj {
        case _txtAccount:
            //todo: more cond, regexp ?
            isSetVal = f(Constant.MinAccountLen, Constant.MaxAccountLen)
            bitIndex = RegisterCond.Account.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtAccount,Meta.borderColor)
                _lblAccountTips.textColor = Meta.logoGreenColor
            }
            else{
                _lblAccountTips.textColor = UIColor.orange
                Meta.setBoderColor(_txtAccount,UIColor.orange)
            }
            
        case _txtPass:
            isSetVal = f(Constant.MinPassLen, Constant.MaxPassLen)
            bitIndex = RegisterCond.Pass.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtPass,Meta.borderColor)
                _lblPasswordTips.textColor = Meta.logoGreenColor
            }
            else{
                Meta.setBoderColor(_txtPass,UIColor.orange)
                _lblPasswordTips.textColor = UIColor.orange
            }
            
            
        case _txtCaptcha:
            isSetVal = f(Constant.CaptchaLen, Constant.CaptchaLen)
            bitIndex = RegisterCond.Captcha.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtCaptcha,Meta.borderColor)
                _lblVerifyCodeTips.textColor = Meta.logoGreenColor
            }
            else{
                Meta.setBoderColor(_txtCaptcha,UIColor.orange)
                _lblVerifyCodeTips.textColor = UIColor.orange
            }
            
            
        default:
            break
        }
        
        _updateRegisterStatus(isSet: isSetVal, bitIndex: bitIndex)
        
        
    }
    
    //密码明文、密文切换
    @IBAction func onPassToggleClicked(sender: AnyObject) {
        
        _txtPass.isSecureTextEntry = !_txtPass.isSecureTextEntry
        if _txtPass.isSecureTextEntry {
            _btnPassToggle.setTitle("show".localized, for: .normal)
            
        } else {
            _btnPassToggle.setTitle("hidden".localized, for: .normal)
        }
    }
    
    
    @IBAction func onRegisterClicked(sender: AnyObject) {

        context.account = _txtAccount.text!.trim()
        context.password = _txtPass.text!.trim()
        
        Snake.sharedInstance.checkAccountInfo(
            context: context,
            type:       RegisterOrVerifyBy.Snake,
            verifyID:   _verifyID!,
            verifyCode: _txtCaptcha.text!.trim()) { [unowned self] ( status, ok)  in
                
                if !ok {
                    self.handleCaptcha()
                    return 
                }
                guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "SnakeBindingPhoneViewController") as? SnakeBindingPhoneViewController else {
                    return
                }
                vc.context = self.context
                
                UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
                
        }
        
    }
    //设置跳转条件
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if #available(iOS 8.0, *) {
            if let dstVC = segue.destination as? AgreementViewController {
                if segue.identifier == "termsOfService"{
                    dstVC.identifier = "termsOfService" //服务条款
                    
                }
                if  segue.identifier == "privacyPolicy" {
                    dstVC.identifier = "privacyPolicy" //隐私政策
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    private func _setUIElements() {
        
        //显示为绑定账户界面,如果未设置tag则为登录界面
        let tagBinding = 1
        
        let tag = context.any as? Int
        if tag ==  tagBinding{
            _btnRegister.setTitle("registerAndBinding".localized , for: .normal)
        }
        
        _addBorderForViews()
        
        Meta.setBoderColor(_txtPass,Meta.borderColor)
        Meta.setBoderColor(_txtAccount,Meta.borderColor)
        Meta.setBoderColor(_txtCaptcha,Meta.borderColor)
        
        Meta.setBtnCornerRadius(_btnRegister)
    }
    
    private func _addBorderForViews() {
        let border = Border(size: 1, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderBottom = border
            v.borderTop = border
            v.borderLeft = border
            v.borderRight = border
        }
        
        f(_vCaptcha)
        f(_btnPassToggle)
        
    }

    
    override func viewDidLoad() {
        _addGestureForViews()
        _addLeftViewForTextFields()
        
        _setUIElements()
        //默认发起一次取图形验证码操作
        handleCaptcha()
        
        super.viewDidLoad()
    }
    
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case _txtAccount:
            _txtPass.becomeFirstResponder()
        case _txtPass:
            _txtCaptcha.becomeFirstResponder()
        case _txtCaptcha:
            _txtCaptcha.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) ->Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        
        var len = 0
        
        switch textField {
        case _txtAccount:
            len = Constant.MaxAccountLen
            
        case _txtPass:
            len = Constant.MaxPassLen
            
        case _txtCaptcha:
            len = Constant.CaptchaLen
            
        default:
            break
        }
        return newLength <= len
    }
    
   
    @objc func handleLawCheck() {
        _isLawChecked  = !_isLawChecked
        
        var isChecked = true
        var img : UIImage?
        if _isLawChecked {
            img = UIImage(named: "lkt0wer_snake_provision_sign.png")
            
        } else {
            isChecked = false
            
            img = UIImage(named: "iPad_snake_provision_not_sign.png")
        }
        
        _vLawChecker.image = img
        
        _updateRegisterStatus(isSet: isChecked,  bitIndex: RegisterCond.Law.rawValue)
        
    }
    
    @objc func handleCaptcha() {
        
        let (w, h) = _captchaMetrics()
        
        Snake.sharedInstance.fetchCaptcha(context: context, width: w, height: h) { [unowned self] (data: NSData?, verifyID: String?, ok: Bool ) in
            if !ok {
                return 
            }
            
            self._verifyID = verifyID
            self._vCaptcha.image = UIImage(data: data! as Data)
        }
        
    }
    
    
    //todo: need remove ?
    private func _addGestureForViews() {
        
        //law check
        var tap = UITapGestureRecognizer(target: self, action: #selector(SnakeRegisterViewController.handleLawCheck))
        tap.numberOfTapsRequired = 1
        _vLawChecker.addGestureRecognizer(tap)
        
        //get captcha
        tap = UITapGestureRecognizer(target: self, action: #selector(SnakeRegisterViewController.handleCaptcha))
        tap.numberOfTapsRequired = 1
        _vCaptcha.addGestureRecognizer(tap)
        
        
    }
    
    
    private func  _captchaMetrics() -> (Int, Int ) {
        //let scale = Meta.screenScale()
        //return (pointW * scale, pointH * scale)
        
        let rect = _vCaptcha.frame
        return (Int(rect.width + 20), Int(rect.height + 20))
        
    }
    
    
    private func _addLeftViewForTextFields() {
        Meta.addLeftImageView(_txtAccount, "lkt0wer_snake_channel_account.png",30)
        Meta.addLeftImageView(_txtPass, "lkt0wer_snake_password_login.png",30)
        Meta.addLeftImageView(_txtCaptcha,"",10)
    }
    
    private func _updateRegisterStatus(isSet: Bool, bitIndex: Int ) {
        
        if isSet  {
            _regCondBitset |= 1 << bitIndex
            
        } else {
            _regCondBitset &= RegisterCond.CheckPassed.rawValue ^ (1 << bitIndex)
        }
        
        if (_regCondBitset & RegisterCond.CheckPassed.rawValue)  == RegisterCond.CheckPassed.rawValue {
            _btnRegister.isEnabled = true
            _btnRegister.backgroundColor = Meta.selectedBgColor
            
        } else {
            _btnRegister.isEnabled = false
            _btnRegister.backgroundColor = UIColor.lightGray
        }
        
        
    }
    
}
