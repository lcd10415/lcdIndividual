//
//  NewPhoneNumberViewController.swift
//  snakesdk
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class NewPhoneNumberViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var _txtVerifyCode: UITextField!
    @IBOutlet weak var _txtPhoneNumber: UITextField!
    
    @IBOutlet weak var _btnConfirm: UIButton!
    @IBOutlet weak var _btnVerifyCode: CountdownButton!
    
    var context: Context!
    
    @IBAction func onPhoneNumberChanged(sender: UITextField) {
        if let txt = sender.text, txt.isMobile()  {
            _btnConfirm.isEnabled = false
            _btnVerifyCode.isEnabled = true
            return
        }
        
        _btnVerifyCode.countdown = false
        _btnConfirm.isEnabled = false

        
    }
    //重新获取验证码
    @IBAction func onReacquireClicked(sender: CountdownButton) {
        
        guard _txtPhoneNumber.text!.isMobile() else{
            return
        }
        
        _btnVerifyCode.countdown = true
        
        context.phone = _txtPhoneNumber.text
        
        Snake.sharedInstance.checkAccountInfo(
            context: context,
            type: RegisterOrVerifyBy.Phone) { [unowned self] (status: PhoneStatus, ok : Bool) -> Void  in
                if !ok {
                    return
                } else {
                    if status == .notRegistered {
                        Snake.sharedInstance.fetchVerifyCode(
                            context: self.context,
                            type:     VerifyCodeBy.Phone)
                        self._btnConfirm.isEnabled = true
                    } else{
                        sender.countdown = false
                        Utils.localShowToast(message: "phoneHasRegistered".localized)
                        self._btnConfirm.isEnabled = false
                    }
                    
                }
        }
    }

    @IBAction func onReturnClicked(sender: UIButton) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
    @IBAction func onVerifyCodeChanged(sender: UITextField) {
        if let txt = sender.text, txt.characters.count == Constant.VerifyCodeLen  {
            _btnConfirm.isEnabled = true
            _btnConfirm.backgroundColor = Meta.selectedBgColor
            return
        }
        
        _btnConfirm.backgroundColor = UIColor.lightGray
        _btnConfirm.isEnabled = false

        
    }
    @IBAction func onConfirmClicked(sender: UIButton) {
        
        let code = _txtVerifyCode.text!.trim()
        context.phone = _txtPhoneNumber.text!
        Snake.sharedInstance.updateUserInfo(context: context, type: ModifyInfo.Phone, verifyCode: code) { (ok: Bool) -> Void in
            if !ok {
                return
            }
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PhoneSuccessSettedViewController") as? PhoneSuccessSettedViewController else {
                        return
                        
                    }
                    
                    vc.context = self.context

                    self.present(vc, animated: true, completion: nil)
        }

        
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case _txtPhoneNumber:
            _txtVerifyCode.becomeFirstResponder()
        case _txtVerifyCode:
            _txtVerifyCode.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) ->Bool {
        var len = 0
        switch textField {
        case _txtPhoneNumber:
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
    
    private func _setUIElement(){
        Meta.setBtnCornerRadius(_btnConfirm)
        
        Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
        Meta.setBoderColor(_txtPhoneNumber,Meta.borderColor)
        
        Meta.addLeftImageView(_txtVerifyCode,"lkt0wer_snake_code_login.png",30)
        Meta.addLeftImageView(_txtPhoneNumber,"lkt0wer_snake_register_phone.png",30)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUIElement()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
