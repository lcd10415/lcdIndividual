//
//  PasswordSetPhoneFillViewController. swift
//  snakesdk
//
//  Created by tgame on 16/7/8.
//  Copyright © 2016年 snakepop. All rights reserved.
//
import UIKit
class PasswordSetPhoneFillViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _lblTips: UILabel!
    
    
    @IBOutlet weak var _btnNext: UIButton!
    @IBOutlet weak var _btnVerifyCode: CountdownButton!
    
    @IBOutlet weak var _txtVerifyCode: UITextField!
    
    
    var context: Context!
    
    private func _setUIElements() {
        Meta.addLeftImageView(_txtVerifyCode,"lkt0wer_snake_register_phone.png",30)
        Utils.setAttributedText(lbl: _lblTips, texts: ["verifyPhone".localized, (context?.account)!])
        
        Meta.setBtnCornerRadius(_btnNext)
        Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
    }
    
    
    @IBAction func onVerifyCodeClicked(sender: CountdownButton) {
        sender.countdown = true
        Snake.sharedInstance.fetchVerifyCode(
            context: context,
            type:     .Phone)
    }
    @IBAction func onNextClicked(sender: UIButton) {
        let code = _txtVerifyCode.text!.trim()
        
        Snake.sharedInstance.verifySMSCode(
            context: context,
            type:     .Phone,
            code:     code) {  [unowned self] (token: String?, ok: Bool)  in
                if !ok {
                    return
                }
                
                self.context.any = token
                
                guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PhonePasswordSetViewController") as? PhonePasswordSetViewController else {
                    return
                }
                if #available(iOS 8.0, *) {
                    vc.modalPresentationStyle = .overCurrentContext
                } else {
                    vc.modalPresentationStyle = .currentContext
                }
                UIViewController.topMostViewController()!.definesPresentationContext = true
                
                vc.context = self.context
                
                UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
                
        }
        
        
    }
    @IBAction func onTextChanged(sender: UITextField) {
        let isOk = sender.text!.characters.count >= Constant.VerifyCodeLen
        if isOk {
            _btnNext.backgroundColor = Meta.selectedBgColor
            
        } else {
            _btnNext.backgroundColor = UIColor.lightGray
        }
        _btnNext.isEnabled = isOk
        
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
        _txtVerifyCode.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        let newLength = currentCharacterCount + string.trim().characters.count - range.length
        
        return newLength <= Constant.VerifyCodeLen
    }
    
    //http://profi.co/show-hide-keyboard-iphone/
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _txtVerifyCode.resignFirstResponder()
        
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
