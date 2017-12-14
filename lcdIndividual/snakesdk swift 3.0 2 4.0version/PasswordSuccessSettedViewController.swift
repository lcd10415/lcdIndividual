//
//  PasswordSuccessSettedViewController .swift
//  snakesdk
//
//  Created by mac on 16/7/19.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class PasswordSuccessSettedViewController: UIViewController {
    
    @IBOutlet weak var _btnConfirm: UIButton!
    
    @IBOutlet weak var _lblTitle: UILabel!
    var titleStr: String?
    
//    weak var context: LoginContext?
//    weak var delegate: SnakeSDKDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _lblTitle.text = titleStr
        
        Meta.setBtnCornerRadius(_btnConfirm)
        // Do any additional setup after loading the view.
    }
    @IBAction func onReturnClicked(sender: UIButton) {
        
        if titleStr == "passwordChange".localized {
            if Utils.curUserType() == .Phone {
                let superVC = UIViewController.topMostViewController()?.presentingViewController! as! PasswordResetViewController
                
                let vc = UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.presentingViewController! as! AccountManagementViewController
                UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true, completion: {
                    vc.context.phone = superVC.context.account
                })
            }
            if Utils.curUserType() == .Snake {
                UIViewController.topMostViewController()?.presentingViewController!.presentingViewController!.presentingViewController!.dismiss(animated: true)
            }
        }
        if titleStr == "忘记密码" {
            self.presentingViewController!.presentingViewController!.presentingViewController!.presentingViewController!
                .dismiss(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //确认的点击事件
    @IBAction func onConfirmClicked(sender: UIButton) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    

}
