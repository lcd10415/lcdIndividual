//
//  PhoneLoginViewController. swift
//  snakesdk
//
//  Created by tgame on 16/7/8.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class PhoneLoginViewController: UIViewController, UITextFieldDelegate {
    
    enum RegisterPhone : Int {
        case Phone
        case Captcha
        case Law
        
        case CheckPassed = 7 // ( 1 << 2 | 1 << 1 | 1 << 0 )
    }
    
    enum LoginWay {
        case Password  //密码登录
        case Code      //验证码登录
    }
    
    //tag for text field
    let tagRegText = 1
    let tagLoginByCodeText = 2
    let tagLoginByPassText = 3
    
    
    //默认为: 手机登录
    @IBOutlet weak var _lblTitle: UILabel!
    
    //选择密码还是验证码登录
    @IBOutlet weak var _btnPassLogin: UIButton!
    @IBOutlet weak var _btnPhoneLogin: UIButton!

    
    //登录
    @IBOutlet weak var _btnLogin: UIButton!
    
    //注册并登录 or 首次登录
    @IBOutlet weak var _btnRegOrFirstLogin: UIButton!
    
    //获取登录验证码
    @IBOutlet weak var _btnLoginVerifyCode: CountdownButton!
    
    //获取注册、首次登录验证码
    @IBOutlet weak var _btnRegOrFistLoginVerifyCode: CountdownButton!

    //登录与注册、首次登录提示
    @IBOutlet weak var _lblRegOrFirstLoginTips: UILabel!
    @IBOutlet weak var _lblLoginTips: UILabel!

    //登录与注册、首次登录验证码输入
    @IBOutlet weak var _txtRegOrFirstLoginVerifyCode: UITextField!
    @IBOutlet weak var _txtLoginVerifyCode: UITextField!
    
    //密码输入
    @IBOutlet weak var _txtPassword: UITextField!

     //登录UI 容器
    @IBOutlet weak var _vLogin: UIView!
    
    //注册UI容器
    @IBOutlet weak var _vRegOrFirstLogin: UIView!
    
    //footer
    @IBOutlet weak var _vFooter: UIView!

    
    //是否同意协议
    @IBOutlet weak var _vLawChecke: UIImageView!
    //首次登录footer
    @IBOutlet weak var _vFirstLoginFooter: UIView!
    
    //注册footer
    @IBOutlet weak var _vRegisterFooter: UIView!
    
    private var _vAll  = [UIView]()
    
    
    private let _normalBorder =  Border(size: 2, color: UIColor.lightGray, offset: UIEdgeInsets.zero)
    private let _selectedBorder = Border(size: 2, color: UIColor.orange, offset: UIEdgeInsets.zero)
    
    //默认验证码登录
    private var _curLoginBy : LoginWay  = .Code
    
    
    var context: Context!
    
    private var _isLawChecked = true
    ///注册需要满足的条件bitset
    private var _regCondBitset = (1 << RegisterPhone.Law.rawValue)  | (1 << RegisterPhone.Phone.rawValue) //默认协议勾选&手机正确

    //手机号状态
    private var _phoneStatus: PhoneStatus?
    
    var phoneStatus: PhoneStatus {
        set {
            _phoneStatus = newValue
        }
        get {
            return _phoneStatus!
        }
    }

    

    @IBAction func onVerifyCodeLoginSelected(sender: UIButton) {
        _curLoginBy = .Code
        _setCurLoginPanel(by: .Code)
    }
    
    @IBAction func onPassLoginSelected(sender: UIButton) {
        
        if _phoneStatus == PhoneStatus.noPassword {
            Utils.localShowToast(message: "Have not set the password".localized)
            return
        }
//        UIColor.cyan
        
        _setCurLoginPanel(by: .Password)

    }
    
    @IBAction func onVerifyCodeClicked(sender: CountdownButton) {
        sender.countdown = true
        Snake.sharedInstance.fetchVerifyCode(
            context: context,
            type:     .Phone)
    }
    
    @IBAction func onRegisterOrFirstLoginClicked(sender: AnyObject) {
        
        if _phoneStatus == PhoneStatus.notRegistered {
            Snake.sharedInstance.phoneRegister(
                context: context,
                verifyCode: _txtRegOrFirstLoginVerifyCode.text!.trim())
            return
        }
        // first login
        Snake.sharedInstance.phoneLogin(context: context, verifyCode: _txtRegOrFirstLoginVerifyCode.text!)

    }

    @IBAction func onFAQClicked(sender: UIButton) {
        guard let dstVC = UIStoryboard(name:"SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "AgreementViewController") as? AgreementViewController else{
            return
        }
        
        dstVC.identifier = "helpCenter"
        self.present(dstVC, animated: true, completion: nil)
    }
    
    
    @IBAction func onLoginClicked(sender: UIButton) {
        
        //验证码登录
        if _curLoginBy == .Code {
            Snake.sharedInstance.phoneLogin(context: context, verifyCode: _txtLoginVerifyCode.text!)
            return
        }
        //密码登录
        if _curLoginBy == .Password {
            
            Snake.sharedInstance.phoneLogin(context: context, password: _txtPassword.text!)
        }
    }
    @IBAction func onTextChanged(_ sender: UITextField) {
        
        var minTextLen = 0
        var bitIndex = 0
        
        switch sender.tag {
        case tagRegText:
            fallthrough
            
        case tagLoginByCodeText:
            minTextLen = Constant.VerifyCodeLen
            bitIndex = RegisterPhone.Captcha.rawValue
            
        case tagLoginByPassText:
            minTextLen = Constant.MinPassLen
            
        default:
            break
        }
        
        //设置字颜色
        let isOk = sender.text!.characters.count >= minTextLen
        if isOk {
            _btnRegOrFirstLogin.backgroundColor = Meta.selectedBgColor
            _btnLogin.backgroundColor = Meta.selectedBgColor
            
        } else {
            _btnLogin.backgroundColor = UIColor.lightGray
            _btnRegOrFirstLogin.backgroundColor = UIColor.lightGray
        }
        
        
        //设置button状态
        if isOk {
            if _phoneStatus == PhoneStatus.notRegistered || _phoneStatus == PhoneStatus.firstLogin {
               _updateRegisterStatus(isSet: isOk, bitIndex: bitIndex)
                return
            }
            
            _btnLogin.isEnabled = true
        
        } else {
            
            if _phoneStatus == PhoneStatus.notRegistered || _phoneStatus == PhoneStatus.firstLogin {
                _updateRegisterStatus(isSet: isOk, bitIndex: bitIndex)
                return
            }
            
            _btnLogin.isEnabled = false
            
        }

    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        guard let vc = segue.destination as? AgreementViewController else{
            return
        }
        
        if segue.identifier == "termsOfService"{
        
            vc.identifier = "termsOfService"
        }
        if segue.identifier == "privacyPolicy"{
            vc.identifier = "privacyPolicy"
        }
    }
        
    override func viewDidLoad() {
        
        _vAll = [_vLogin, _vRegOrFirstLogin]
        _addGestureForViews()
        _setCurDashboard()
        
        Meta.addLeftImageView(_txtPassword, "lkt0wer_snake_password_login.png",30)
        Meta.addLeftImageView(_txtLoginVerifyCode, "lkt0wer_snake_code_login.png",30)
        Meta.addLeftImageView(_txtRegOrFirstLoginVerifyCode,"lkt0wer_snake_register_phone.png",30)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtPassword.resignFirstResponder()
        _txtLoginVerifyCode.resignFirstResponder()
        _txtRegOrFirstLoginVerifyCode.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        
        var maxTextLen = 0
        
        switch textField.tag {
        case tagRegText:
            fallthrough
            
        case tagLoginByCodeText:
            maxTextLen = Constant.VerifyCodeLen
            
        case tagLoginByPassText:
            maxTextLen = Constant.MaxPassLen
            
        default:
            break
        }

        
        return newLength <= maxTextLen
    }
    
    @objc func handleLawCheckImage() {
        _isLawChecked  = !_isLawChecked
        
        var isChecked = true
        var img : UIImage?
        if _isLawChecked {
            img = UIImage(named: "lkt0wer_snake_provision_sign.png")
            
        } else {
            isChecked = false
            
            img = UIImage(named: "iPad_snake_provision_not_sign.png")
        }
        
        _vLawChecke.image = img
        
        _updateRegisterStatus(isSet: isChecked,  bitIndex: RegisterPhone.Law.rawValue)
        
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //todo: merge three
        if _txtRegOrFirstLoginVerifyCode.isFirstResponder {
            _txtRegOrFirstLoginVerifyCode.resignFirstResponder()
        }
        
        if _txtLoginVerifyCode.isFirstResponder {
            _txtLoginVerifyCode.resignFirstResponder()
        }
        
        if _txtPassword.isFirstResponder {
            _txtPassword.resignFirstResponder()
        }
        
        
    }
    
    
    private func _updateRegisterStatus(isSet: Bool, bitIndex: Int ) {
        
        
        if isSet  {
            _regCondBitset |= 1 << bitIndex
        
            
        } else {
            _regCondBitset &= RegisterPhone.CheckPassed.rawValue ^ (1 << bitIndex)
        }
        
        
        if (_regCondBitset & RegisterPhone.CheckPassed.rawValue)  == RegisterPhone.CheckPassed.rawValue {
            _btnRegOrFirstLogin.isEnabled = true
            _btnRegOrFirstLogin.backgroundColor = Meta.selectedBgColor
            
        } else {
            _btnRegOrFirstLogin.isEnabled = false
            _btnRegOrFirstLogin.backgroundColor = UIColor.lightGray
        }
        
        
    }

    
    //设置显示注册并登录还是 首次登录界面
    private func _setRegOrFirstLoginUI() {
        
        _vRegOrFirstLogin.isHidden = false
        _vRegisterFooter.isHidden = true
        _vFirstLoginFooter.isHidden = true 
        
        Utils.setAttributedText(lbl: _lblRegOrFirstLoginTips, texts: [ "verifyPhone".localized, context.phone!],colors: [UIColor.black,UIColor.orange])
        
        _vFooter.isHidden = false
        
        if _phoneStatus == .notRegistered {
            _lblTitle.text = "phoneRegister".localized
            _vRegisterFooter.isHidden = false
            _btnRegOrFirstLogin.setTitle("registerAndLogin".localized, for: .normal)
            return
        }
        
        _btnRegOrFirstLogin.setTitle("login".localized, for: .normal)
        _vFirstLoginFooter.isHidden = false
        
        
    }
    
    //根据状态确定是显示:
    // 1. 登录界面
    // 2. 注册并登录界面
    // 3. 第一次登录界面
    private func _setCurDashboard() {
        
        Meta.setBoderColor(_txtPassword,Meta.borderColor)
        Meta.setBoderColor(_txtLoginVerifyCode,Meta.borderColor)
        Meta.setBoderColor(_txtRegOrFirstLoginVerifyCode,Meta.borderColor)
        
        Meta.setBtnCornerRadius(_btnLogin)
        Meta.setBtnCornerRadius(_btnRegOrFirstLogin)
//        V(_btnPhoneLogin)
        
        for v in _vAll {
            v.isHidden = true
        }
        
        var by = LoginWay.Code
        
        switch _phoneStatus! {
        case .notRegistered:
            _setRegOrFirstLoginUI()
            return
            
        case .firstLogin:
            _setRegOrFirstLoginUI()
            return

            
        case .noPassword:
            _vLogin.isHidden = false
            by = .Code

        case .havePassword:
            _vLogin.isHidden = false
            by = .Password

            
        default:
            break
        }
        
        Utils.setAttributedText(lbl: _lblLoginTips,  texts: ["verifyPhone".localized, context.phone!], colors: [UIColor.black,UIColor.orange])
        _vFooter.isHidden = true
        
        _setCurLoginPanel(by: by)
    }
    
    //设置当前登录面板: 验证码还是密码
    private func _setCurLoginPanel( by: LoginWay = .Code) {
        _curLoginBy = by
        
        _setBorders(by: by)
        
        if by == .Code {
            _btnPhoneLogin.isSelected = true
            _btnPassLogin.isSelected = false
            _btnLoginVerifyCode.isHidden = false
            _txtLoginVerifyCode.isHidden = false
            _txtPassword.isHidden = true
            return
        }
        if by == .Password {
            _btnLoginVerifyCode.isHidden = true
            _txtLoginVerifyCode.isHidden = true
            _txtPassword.isHidden = false
            
            _btnPhoneLogin.isSelected = false
            _btnPassLogin.isSelected = true
        }
    }
    
    func _addGestureForViews(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhoneLoginViewController.handleLawCheckImage))
        tap.numberOfTapsRequired = 1
        _vLawChecke.addGestureRecognizer(tap)
    }
    
    private func _setBorders(by: LoginWay) {
        
        if by == LoginWay.Code {
            _btnPassLogin.borderBottom = _normalBorder
            _btnPhoneLogin.borderBottom = _selectedBorder

            return
        }
        
        _btnPassLogin.borderBottom = _selectedBorder
        _btnPhoneLogin.borderBottom = _normalBorder

    }
    
  
    
    
    
    /*
     //MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
