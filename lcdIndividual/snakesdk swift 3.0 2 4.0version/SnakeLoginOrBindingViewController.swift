//
//  PhoneLoginViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/7.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class SnakeLoginOrBindingViewController: UIViewController,UITextFieldDelegate {
    
    enum RequiredCond : Int {
        case Account
        case Pass
        
        case CheckPassed = 3 // ( 1 << 1 | 1 << 0 )
    }
    
    
    @IBOutlet weak var _txtPass: UITextField!
    @IBOutlet weak var _txtAccount: UITextField!
    
    @IBOutlet weak var _btnLoginOrBinding: UIButton!
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblSnakeTips: UILabel!
    @IBOutlet weak var _lblPasswordTips: UILabel!
    
    var context: Context!
    var textFieldCons: NSLayoutConstraint?
    
    ///登录、绑定需要满足的条件bitset
    private var _requiredCondBitset = 0
    
    private let _IDSegueToSnakeRegisterVC = "SnakeRegisterViewController"
    private let _IDSegueToForgotenAccountFillVC = "ForgotenAccountFillViewController"
    
    @IBAction func onLoginOrBindingClicked(sender: AnyObject) {
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
            context.account = _txtAccount.text!.trim()
            context.password = _txtPass.text!.trim()
            Snake.sharedInstance.snakeBinding(context: context)
        } else {
            context.account = _txtAccount.text!.trim()
            context.password = _txtPass.text!.trim()
            Snake.sharedInstance.snakeLogin( context: context)
        }
    }
 

    
    @IBAction func onTextChanged(_ obj: UITextField) {
        let len = obj.text!.characters.count
        
        let f = { ( min: Int , max: Int) -> Bool in
            if len >= min && len <= max {
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
            bitIndex = RequiredCond.Account.rawValue
            if isSetVal {
                _lblSnakeTips.textColor = Meta.logoGreenColor
                Meta.setBoderColor(_txtAccount,Meta.borderColor)
            }
            else{
                 Meta.setBoderColor(_txtAccount,UIColor.orange)
                _lblSnakeTips.textColor = UIColor.orange
            }

            
        case _txtPass:
            isSetVal = f(Constant.MinPassLen, Constant.MaxPassLen)
            bitIndex = RequiredCond.Pass.rawValue
            if isSetVal {
                Meta.setBoderColor(_txtPass,Meta.borderColor)
                _lblPasswordTips.textColor = Meta.logoGreenColor
            }
            else{
                Meta.setBoderColor(_txtPass,UIColor.orange)
                _lblPasswordTips.textColor = UIColor.orange
            }

            
        default:
            break
        }
        
        
        
        //设置字颜色
        let isOk = _txtPass.text!.characters.count >= Constant.MinPassLen
        if isOk {
            _btnLoginOrBinding.backgroundColor = Meta.selectedBgColor
            
            
        } else {
            _btnLoginOrBinding.backgroundColor = UIColor.lightGray
           
        }
        
        _updateRequiredStatus(isSet: isSetVal, bitIndex: bitIndex)
        
        
    }
    
    private func _updateRequiredStatus(isSet: Bool, bitIndex: Int ) {
        
        if isSet  {
            _requiredCondBitset |= 1 << bitIndex
            
        } else {
            _requiredCondBitset &= RequiredCond.CheckPassed.rawValue ^ (1 << bitIndex)
        }
        
        if (_requiredCondBitset & RequiredCond.CheckPassed.rawValue)  == RequiredCond.CheckPassed.rawValue {
            _btnLoginOrBinding.isEnabled = true
            
        } else {
            _btnLoginOrBinding.isEnabled = false
        }
        
        
    }
    
    private func _addLeftViewForTextFields() {
        Meta.addLeftImageView(_txtAccount, "lkt0wer_snake_channel_account.png",30)
        Meta.addLeftImageView(_txtPass, "lkt0wer_snake_password_login.png",30)
        
    }
    
    private func _setUIElements() {
        Meta.setBtnCornerRadius(_btnLoginOrBinding)
        
        Meta.setBoderColor(_txtAccount,Meta.borderColor)
        Meta.setBoderColor(_txtPass,Meta.borderColor)
        
        //显示为绑定账户界面,如果未设置tag则为登录界面
        let tagBinding = 1
        
        let tag = context.any as? Int
        if tag ==  tagBinding{
            _btnLoginOrBinding.setTitle("binding".localized , for: .normal)
        }
        
        _btnLoginOrBinding.isEnabled = false
        
        _addLeftViewForTextFields()

    }
    
    override func viewDidLoad() {
        _setUIElements()
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
        case _txtAccount:
                _txtPass.becomeFirstResponder()
        case _txtPass:
                _txtPass.resignFirstResponder()
        default:
            break
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
            
        default:
            break
        }
        return newLength <= len
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let len = textField.text!.characters.count
        
        let f = { ( min: Int , max: Int) -> Bool in
            if len >= min && len <= max {
                return true
            }
            return false
            
        }
        switch textField {
        case _txtAccount:
            if f(Constant.MinAccountLen, Constant.MaxAccountLen) {
            }   else{
            Utils.localShowToast(message: "accountTips".localized)
            }
        case _txtPass:
            if f(Constant.MinPassLen,Constant.MaxPassLen) {
            }  else{
                Utils.localShowToast(message: "passwordTips".localized)
            }
        default:
            break
        }
        
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if _txtPass.isFirstResponder {
            _txtPass.resignFirstResponder()
        }
        
        if _txtAccount.isFirstResponder {
            _txtAccount.resignFirstResponder()
        }
    }
    
    
    //MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //todo prompt context & delegate to extension
        if segue.identifier == _IDSegueToSnakeRegisterVC {
            if let vc = segue.destination as? SnakeRegisterViewController {
                vc.context = context
            }
            return
        }
        
        if let vc = segue.destination as? ForgotenAccountFillViewController {
            vc.context = context

        }
        
        
    }
    
}
