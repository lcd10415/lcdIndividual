//
//  PasswordSetPhoneFillViewController. swift
//  snakesdk
//
//  Created by tgame on 16/7/8.
//  Copyright © 2016年 snakepop. All rights reserved.
//
import UIKit
typealias strengthChcker =  (String)-> Bool
class PhonePasswordSetViewController: UIViewController, UITextFieldDelegate {
    
    //密码强度
    private enum Strength: Int {
        case Invalid;
        case Weak;
        case Normal;
        case Strong;
    }
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblStrength: UILabel!
    
    @IBOutlet weak var _txtPassword: UITextField!
    @IBOutlet weak var _btnConfirm: UIButton!
    @IBOutlet weak var _btnPasswordConfirm: UIButton!
    @IBOutlet weak var _btnPasswordToggle: UIButton!
    
    @IBOutlet weak var _vWeak: UIView!
    @IBOutlet weak var _vNormal: UIView!
    @IBOutlet weak var _vStrong: UIView!
    
    //将要设置密码
    @IBOutlet weak var _vPassWillSet: UIView!
    
    //已经设置密码
    @IBOutlet weak var _vPassDidSet: UIView!
    //从低到高
    var _vStrengths = [UIView]()
    
    var context: Context!
    
    @IBAction func onPasswordToggle(sender: UIButton) {
        
        _txtPassword.isSecureTextEntry = !_txtPassword.isSecureTextEntry
        if _txtPassword.isSecureTextEntry {
            _btnPasswordToggle.setTitle("show".localized, for: .normal)
            
        } else {
            _btnPasswordToggle.setTitle("hidden".localized, for: .normal)
        }
        
    }
    
    
    @IBAction func onConfirmSuccessClicked(sender: UIButton) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
  
    @IBAction func onConfirmClicked(sender: AnyObject) {
        
        context.password = _txtPassword.text!.trim()
        context.phone = ""
        
        Snake.sharedInstance.updateUserInfo(context: context!, type: ModifyInfo.PasswordModify,verifyCode: context.any as! String) {
            [unowned self ] (_) in
            self._vPassWillSet.isHidden = true
            self._vPassDidSet.isHidden = false
        }
        
    }
    @IBAction func onTextChanged(sender: UITextField) {
        
        //设置字颜色
        let isOk = sender.text!.characters.count >= Constant.MinPassLen
        _btnConfirm.backgroundColor = isOk ? Meta.selectedBgColor :UIColor.lightGray
        _btnConfirm.isEnabled = isOk
        
        _updatePasswordStrength()
        
    }
    
    
    override func viewDidLoad() {
        _setUIElements()
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtPassword.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        
        return newLength <= Constant.MaxPassLen
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _txtPassword.resignFirstResponder()
        
    }
    
    
    private func _setUIElements() {
        self._vPassWillSet.isHidden = false
        self._vPassDidSet.isHidden = true
        
        _vStrengths = [_vWeak, _vNormal, _vStrong]
        for v in _vStrengths {
            v.backgroundColor = UIColor.clear
        }
        
        _addBorderForViews()
        
        Meta.addLeftImageView(_txtPassword,"lkt0wer_snake_password_login.png",30)
        Meta.setBtnCornerRadius(_btnConfirm)
        Meta.setBtnCornerRadius(_btnPasswordConfirm)
        Meta.setBoderColor(_txtPassword,Meta.borderColor)
    }
    
    
    private func _addBorderForViews() {
        
        let border = Border(size: 1, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderTop = border
            v.borderBottom = border
            v.borderLeft = border
            v.borderRight = border
            
        }
        for v in _vStrengths {
            f(v)
        }
        f(_btnPasswordToggle)
    }
    
    // 密码强度
    private func _updatePasswordStrength() {
        
        for v in _vStrengths {
            v.backgroundColor = UIColor.clear
        }
        
        
        let strength = { (password: String)-> Strength in
            if password.characters.count < Constant.MinPassLen {
                return .Invalid
            }
            
            if password.hasSpecials() {
                return .Strong
            }
            
            if password.hasNumerics() && password.hasCharacters() {
                return .Normal
            }
            
            return .Weak
            
        }(self._txtPassword.text! )
        
        if strength == .Invalid {
            return
        }
        
        for i in 1...strength.rawValue {
            _vStrengths[i-1].backgroundColor = Meta.selectedBgColor
        }
        
    }
    
    //MARK: - Navigation
    
    //     // In a storyboard-based application, you will often want to do a little preparation before navigation
    //     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //     // Get the new view controller using segue.destinationViewController.
    //     // Pass the selected object to the new view controller.
    //     }
    //
    //    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    //           return  _txtVerifyCode.text!.characters.count >= Constant.VerifyCodeLen
    //        
    //    }
    
    
}
