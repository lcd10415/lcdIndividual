//
//  PasswordResetViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/13.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit


class PasswordResetViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var _txtPass: UITextField!
    @IBOutlet weak var _lblTitle: UILabel!
    
    @IBOutlet weak var _btnPassToggle: UIButton!
    @IBOutlet weak var _btnConfirm: UIButton!
    @IBOutlet weak var _lblPasswordTips: UILabel!
    
    
    var context: Context!
    var titleStr: String?
    
    
    var modifyInfo : ModifyInfo?
    @IBAction func onReturnClicked(sender: UIButton) {
        if  titleStr == "passwordChange".localized {
            if Utils.curUserType() == .Phone {
                let vc = UIViewController.topMostViewController()?.presentingViewController!.presentingViewController as! AccountManagementViewController
                UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {
                    vc.context.phone = self.context.account
                })
                return
            }
            if Utils.curUserType() == .Snake {
                UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.dismiss(animated: true)
            }

        }
        if titleStr == "忘记密码" {
            UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true)
        }
    }
    
    @IBAction func onTextChanged(_ sender: UITextField) {
        let len = sender.text?.characters.count
        
        if len! >= Constant.MinPassLen && len! <= Constant.MaxPassLen  {
            _btnConfirm.isEnabled = true
            _btnConfirm.backgroundColor = Meta.selectedBgColor
            Meta.setBoderColor(_txtPass,Meta.borderColor)
            _lblPasswordTips.textColor = Meta.logoGreenColor
            return
        }
        Meta.setBoderColor(_txtPass,UIColor.orange)
        _btnConfirm.backgroundColor = UIColor.lightGray
        _btnConfirm.isEnabled = false
        _lblPasswordTips.textColor = UIColor.orange

        
    }
    @IBAction func onPassToggleClicked(sender: AnyObject) {
        _txtPass.isSecureTextEntry = !_txtPass.isSecureTextEntry
        if _txtPass.isSecureTextEntry {
            _btnPassToggle.setTitle("show".localized, for: .normal)
            
        } else {
            _btnPassToggle.setTitle("hidden".localized, for: .normal)
        }
    }
    
    // context: Context, type: ModifyInfo, verifyCode: String = "", completion: (Bool)->Void
    @IBAction func onConfirmClicked(sender: AnyObject) {
        context.password = _txtPass.text!.trim()
        
        Snake.sharedInstance.updateUserInfo(context: context, type:modifyInfo!) { (ok :Bool)->Void in
            if ok{
                guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PasswordSuccessSettedViewController") as? PasswordSuccessSettedViewController else {
                    return
                    
                }
                vc.titleStr = self._lblTitle.text
                self.present(vc, animated: true, completion: nil)
                
            }
            else {
               return
               
            }
        }
      
    }
    override func viewDidLoad() {
        Meta.addLeftImageView(_txtPass,"lkt0wer_snake_password_login.png",30)
        _addBorderForViews()
        
        Meta.setBtnCornerRadius(_btnConfirm)
        
        _lblTitle.text = titleStr
        super.viewDidLoad()
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtPass.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) ->Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        
        return newLength <= Constant.MaxPassLen
    }
    
    private func _addBorderForViews() {
        let border = Border(size: 1, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderBottom = border
            v.borderTop = border
            v.borderRight = border
            v.borderLeft = border
        }
        
        f(_btnPassToggle)
        
       Meta.setBoderColor(_txtPass,Meta.borderColor)
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
