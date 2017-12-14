//
//  CurrentPhoneNumberViewController.swift
//  snakesdk
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class CurrentPhoneViewController: UIViewController {

    @IBOutlet weak var _lblPhoneNumber: UILabel!
    
    @IBOutlet weak var _btnSwitch: UIButton!
    var context: Context!
   
    private func _setupAttributes(){
        let maskedText = context.phone!.maskedText()

        Utils.setAttributedText(lbl: _lblPhoneNumber,texts: ["currentPhoneNumber".localized, maskedText])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupAttributes()
        
        Meta.setBtnCornerRadius(_btnSwitch)
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onChangeClicked(sender: UIButton) {
        guard let vc = UIStoryboard(name: "SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "FecthVerifyCodeFillViewController") as? FecthVerifyCodeFillViewController else{
            return
        }
        
        vc.context = self.context
        self.present(vc, animated: true, completion: nil)
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
