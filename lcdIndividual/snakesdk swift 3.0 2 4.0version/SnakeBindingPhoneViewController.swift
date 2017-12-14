//
//  SnakeBindingPhoneViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/8.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class SnakeBindingPhoneViewController: UIViewController, UITextFieldDelegate {
    
    enum RequiredCond : Int {
        case Phone
        case VerifyCode
        
        case CheckPassed = 3 // (1 << 1 | 1 << 0 )
    }
    
    
    @IBOutlet weak var _txtPhone: UITextField!
    @IBOutlet weak var _txtVerifyCode: UITextField!
    
    @IBOutlet weak var _btnVerifyCode: CountdownButton!
    @IBOutlet weak var _btnRegister: UIButton!
    
    
    var context: Context!
    
    ///注册需要满足的条件bitset
    private var _reqCondBitset = 0
    
    
    @IBAction func onVerifyCodeClicked(sender: AnyObject) {
        _btnVerifyCode.countdown = true
        
        context.phone = _txtPhone.text?.trim()
        
        Snake.sharedInstance.fetchVerifyCode( context: context, type: .Phone)
        
    }
    @IBAction func onRegisterClicked(sender: AnyObject) {
        //显示为绑定账户界面,如果未设置tag则为登录界面
        let tagBinding = 1
        
        let tag = context.any as? Int
        let users = Store.sharedInstance.users()!
        if tag ==  tagBinding{
            for (_, user) in users.enumerated() {
                if user.type  == LoginBy.Guest.rawValue {
                    Store.sharedInstance.deleteUser(id: Int(user.id))
                    
                }
            }
            context.phone =  _txtPhone.text!.trim()
            Snake.sharedInstance.snakeRegisterAndBinding(context: context,verifyCode:_txtVerifyCode.text!.trim())
        } else {
            context.phone =  _txtPhone.text!.trim()
            Snake.sharedInstance.snakeRegister( context: context, verifyCode: _txtVerifyCode.text!.trim())
        }
       
        
    }
    
    
    @IBAction func onTextChanged(_ obj: UITextField) {
        
        let len = obj.text?.characters.count
        
        var isSetVal = true
        var bitIndex = 0
        
        switch obj {
        case _txtPhone:
            //todo: more cond, regexp ?
            isSetVal = len == Constant.PhoneNumberLen ? true: false
            bitIndex = RequiredCond.Phone.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtPhone,Meta.borderColor)
            }
            else{
                Meta.setBoderColor(_txtPhone,UIColor.orange)
            }
            
        case _txtVerifyCode:
            isSetVal = len == Constant.VerifyCodeLen ? true: false
            bitIndex = RequiredCond.VerifyCode.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
            }
            else{
                Meta.setBoderColor(_txtVerifyCode,UIColor.orange)
            }
            
        default:
            break
        }
    
        if obj == _txtPhone {
            _btnVerifyCode.isEnabled = isSetVal
        }
        
        _updateRequiredStatus(isSet: isSetVal, bitIndex: bitIndex)
        
    }
    
    private func _setUpElements() {
        //显示为绑定账户界面,如果未设置tag则为登录界面
        let tagBinding = 1
        
        let tag = context.any as? Int
        if tag ==  tagBinding{
            _btnRegister.setTitle("registerAndBinding".localized , for: .normal)
        }
        _btnVerifyCode.isEnabled = false
        
        Meta.setBoderColor(_txtPhone,Meta.borderColor)
        Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
        Meta.addLeftImageView(_txtVerifyCode,"lkt0wer_snake_password_login.png",30)
        Meta.addLeftImageView(_txtPhone,"lkt0wer_snake_register_phone.png",30)
        Meta.setBtnCornerRadius(_btnRegister)
        
    }
    
    override func viewDidLoad() {
        _setUpElements()

        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case _txtPhone:
            _txtVerifyCode.becomeFirstResponder()
        case _txtVerifyCode:
            _txtVerifyCode.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var len = 0
        switch textField {
        case _txtPhone:
            len = Constant.PhoneNumberLen
            
            
        case _txtVerifyCode:
            len = Constant.VerifyCodeLen
            
        default:
            break
        }
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        return newLength <= len
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _txtVerifyCode.resignFirstResponder()
        
    }
    
    
    private func _updateRequiredStatus(isSet: Bool, bitIndex: Int ) {
        
        if isSet  {
            _reqCondBitset |= 1 << bitIndex
            
        } else {
            _reqCondBitset &= RequiredCond.CheckPassed.rawValue ^ (1 << bitIndex)
        }
        
        if (_reqCondBitset & RequiredCond.CheckPassed.rawValue)  == RequiredCond.CheckPassed.rawValue {
            _btnRegister.isEnabled = true
            _btnRegister.backgroundColor = Meta.selectedBgColor
            
        } else {
            _btnRegister.backgroundColor = UIColor.lightGray
            _btnRegister.isEnabled = false
        }
        
        
    }
    
  
    
}
