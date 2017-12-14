//
//  ForgotenAccountVerifyCodeFillViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/13.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit
import Foundation;

class ForgotenAccountVerifyCodeFillViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblAccount: UILabel!
    @IBOutlet weak var _lblPhone: UILabel!
    
    @IBOutlet weak var _btnVerifyCode: CountdownButton!
    @IBOutlet weak var _btnNext: UIButton!
    
    @IBOutlet weak var _lblVerifyCode: UILabel!
    @IBOutlet weak var _txtVerifyCode: UITextField!
    
    var context: Context!
    var titleStr: String? = ""
    
    
    var modifyInfo : ModifyInfo?
    
    @IBAction func onReturnClicked(sender: UIButton) {
        if titleStr == "passwordChange".localized {
            
            if Utils.curUserType() == .Phone {
                context.phone = context.account
                let vc = UIViewController.topMostViewController()?.presentingViewController as! AccountManagementViewController
                self.dismiss(animated: true, completion: {
                    vc.context.phone = self.context.account
                })
                return
            }
            if Utils.curUserType() == .Snake {
                UIViewController.topMostViewController()?.presentingViewController!.dismiss(animated: true)
            }
        }
        if titleStr == "忘记密码" {
            UIViewController.topMostViewController()?.presentingViewController?.presentingViewController?.dismiss(animated: true)
        }
        
    }
    @IBAction func onTextChanged(_ sender: UITextField) {
        
        if let txt = sender.text, txt.characters.count == Constant.VerifyCodeLen  {
            _btnNext.isEnabled = true
            _btnNext.backgroundColor = Meta.selectedBgColor
            _lblVerifyCode.textColor = Meta.logoGreenColor
            Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
            return
        }
        _lblVerifyCode.textColor = UIColor.orange
        _btnNext.backgroundColor = Meta.borderColor
        Meta.setBoderColor(_txtVerifyCode,UIColor.orange)
        _btnNext.isEnabled = false
    }

    @IBAction func onVerifyCodeClicked(sender: AnyObject) {
        _btnVerifyCode.countdown = true
        if Utils.curUserType() == .Phone {
            context.phone = context.account
        }
        Snake.sharedInstance.fetchVerifyCode(
            context: context,
            type:     context.any as! VerifyCodeBy)
    }
    
    @IBAction func onNextClicked(sender: AnyObject) {
        
        let code = _txtVerifyCode.text!.trim()
        
        Snake.sharedInstance.verifySMSCode(
            context: context,
            type:     context.any as! VerifyCodeBy,
            code:     code) {  [unowned self] (token: String?, ok: Bool)  in
                
            if !ok  {
                return
            }
                        
            self.context.any = token

            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PasswordResetViewController") as? PasswordResetViewController else {
                return
            }
            
            vc.titleStr = self._lblTitle.text
            vc.context = self.context
            vc.modifyInfo = self.modifyInfo
             
            self.present(vc, animated: true, completion: nil)
            
        }

 
    }
    
    override func viewDidLoad() {
        _setUIElement()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtVerifyCode.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let countOfCharacter = textField.text?.characters.count ?? 0
        if range.length + range.location > countOfCharacter {
            return false
        }
        
        let newLength = countOfCharacter + string.trim().characters.count - range.length
        
        return newLength <= Constant.VerifyCodeLen
    }
    
    
    private func _setUIElement(){
        //http://stackoverflow.com/questions/24666515/how-do-i-make-an-attributed-string-using-swift
        Utils.setAttributedText(lbl: _lblAccount, texts: [ context.account!.localized,"password".localized], colors: [ Meta.accountColor,UIColor.gray])
    
        Utils.setAttributedText(lbl: _lblPhone, texts: ["accountForPhone".localized, context.phone!.localized], colors: [UIColor.gray, Meta.accountColor])
        Meta.setBtnCornerRadius(_btnNext)
        Meta.addLeftImageView(_txtVerifyCode,"",10)
        Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
        
        _lblTitle.text = titleStr
    }
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    //queryUserInfo
 

}
