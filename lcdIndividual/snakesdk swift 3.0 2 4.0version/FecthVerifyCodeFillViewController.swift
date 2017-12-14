//
//  GainVerifyCodeFillViewController.swift
//  snakesdk
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class FecthVerifyCodeFillViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var _lblTips: UILabel!
    @IBOutlet weak var _txtVerifyCode: UITextField!
    
    @IBOutlet weak var _btnVerifyCode: CountdownButton!
    
    @IBOutlet weak var _btnNext: UIButton!
    
    var context: Context!
   
    
    private func _setupAttributes(){
        _btnVerifyCode.countdown = false

        let maskedText = context.phone!.maskedText()
        _lblTips.text = "switchingAccount".localized + maskedText
        
        Meta.setBoderColor(_txtVerifyCode,Meta.borderColor)
        
        Utils.setAttributedText(lbl: _lblTips, texts: [ "switchingAccount".localized, maskedText ])
    }
    @IBAction func onTextChanged(_ sender: UITextField) {
        if let txt = sender.text, txt.characters.count == Constant.VerifyCodeLen  {
            _btnNext.isEnabled = true
            _btnNext.backgroundColor = Meta.selectedBgColor
            return
        }
        
        _btnNext.backgroundColor = UIColor.lightGray
        _btnNext.isEnabled = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupAttributes()
        Meta.setBtnCornerRadius(_btnNext)
        Meta.addLeftImageView(_txtVerifyCode,"lkt0wer_snake_code_login.png",30)
        // Do any additional setup after loading the view.
    }

    @IBAction func onVerifyCodeClicked(sender: CountdownButton) {
        _btnVerifyCode.countdown = true
        
        Snake.sharedInstance.fetchVerifyCode(
            context: context,
            type:     context.any as! VerifyCodeBy)
       
    }
    @IBAction func onReturnClicked(sender: UIButton) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func onNextClicked(sender: AnyObject) {
        let code = _txtVerifyCode.text!.trim()
        
        Snake.sharedInstance.verifySMSCode(
            context: context,
            type:     context.any as! VerifyCodeBy,
            code:     code) {  [unowned self] (token: String?, ok : Bool)  in
                if !ok {
                    return
                }
                
                guard let vc = UIStoryboard(name: "SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "NewPhoneNumberViewController") as? NewPhoneNumberViewController else{
                    return
                }
                
                vc.context = self.context
                vc.context.any = token
                
                self.present(vc, animated: true, completion: nil)
                self._btnVerifyCode.countdown = false
        }
        
        
        
    }
    func borderRectForBounds() -> CGRect {
        return CGRect(x:0, y:00, width:0, height:0)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _txtVerifyCode.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) ->Bool {
        
        var len = 0
        switch textField {
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
