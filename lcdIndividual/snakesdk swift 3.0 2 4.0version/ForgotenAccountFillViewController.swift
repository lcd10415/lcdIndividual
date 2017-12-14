//
//  ForgotenAccountFillViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/13.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class ForgotenAccountFillViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _btnNext: UIButton!
    @IBOutlet weak var _txtAccount: UITextField!
    @IBOutlet weak var _lblAccountTips: UILabel!
    
    var context: Context!
    
    
    @IBAction func onAccountChanged(_ sender: UITextField) {
        
        let len = sender.text?.characters.count
        if len! >= Constant.MinAccountLen && len! <= Constant.MaxAccountLen  {
            _btnNext.isEnabled = true
            Meta.setBoderColor(_txtAccount,Meta.borderColor)
            _btnNext.backgroundColor = Meta.selectedBgColor
            _lblAccountTips.textColor = Meta.logoGreenColor
            return
        }
        Meta.setBoderColor(_txtAccount,UIColor.orange)
        _lblAccountTips.textColor = UIColor.orange
        _btnNext.backgroundColor = UIColor.lightGray
        _btnNext.isEnabled = false
    }
    
    @IBAction func onNextClicked(sender: AnyObject) {
        self.context.account = _txtAccount.text!.trim()
        
        Snake.sharedInstance.queryUserInfo( context: context) {  [unowned self] (markedPhone: String?, ok: Bool)  in
   
            if !ok {
                return
            }
            
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "ForgotenAccountVerifyCodeFillViewController") as? ForgotenAccountVerifyCodeFillViewController else {
                return
            }
            
            vc.titleStr = self._lblTitle.text
            vc.context = self.context
            vc.context.any = VerifyCodeBy.Name
            vc.context.phone = markedPhone
            vc.modifyInfo = ModifyInfo.PasswordFind
            
            self.present(vc, animated: true, completion: nil)

        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Meta.setBtnCornerRadius(_btnNext)
        Meta.addLeftImageView(_txtAccount,"",10)
        Meta.setBoderColor(_txtAccount,Meta.borderColor)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtAccount.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        return newLength <= Constant.MaxAccountLen
    }
    

//    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
//        return true
//    }
//    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        print("prepareForSegue")
//    }

}
