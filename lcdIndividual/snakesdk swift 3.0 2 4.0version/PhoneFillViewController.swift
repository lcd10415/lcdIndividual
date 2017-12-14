//
//  PhoneFillViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/7.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class PhoneFillViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var _txtPhone: UITextField!
    @IBOutlet weak var _btnNext: UIButton!

    var context: Context!
    
    @IBAction func onPhoneChanged(phone: UITextField) {
        if let txt = phone.text, txt.isMobile()  {
            _btnNext.isEnabled = true
            _btnNext.backgroundColor = Meta.selectedBgColor
            return
        }
        _btnNext.isEnabled = false
        _btnNext.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func onNextClicked(sender: UIButton) {
        
        let phone = _txtPhone.text!.trim()
        context.phone = phone
        
        Snake.sharedInstance.checkAccountInfo(
            context: context,
            type: RegisterOrVerifyBy.Phone) { [unowned self] (status: PhoneStatus, ok : Bool) -> Void  in
                if !ok {
                    return 
                }
                
                guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PhoneLoginViewController") as? PhoneLoginViewController else {
                    return
                }
                
                vc.context = self.context
                vc.phoneStatus = status
                
                UIViewController.topMostViewController()!.present(vc, animated: true, completion: { 
                    self.view.isHidden = true
                })
                
        }
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        Meta.setBtnCornerRadius(_btnNext)
        Meta.setBoderColor(_txtPhone,Meta.borderColor)
        
        Meta.addLeftImageView(_txtPhone,"",10)
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtPhone.resignFirstResponder()
        return true
    }
    
    //MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        return newLength <= Constant.PhoneNumberLen
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _txtPhone.resignFirstResponder()
        
    }
    
       deinit{
        NotificationCenter.default.removeObserver(self)
    }
     //MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let dstVC = segue.destination as? PhoneLoginViewController {
            dstVC.context = context
            context.phone = _txtPhone.text!
        }
    }
}
