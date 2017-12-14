//
//  AlertViewController.swift
//  snakesdk
//
//  Created by mac on 2016/10/25.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak var _vBackView: UIView!
    var context: Context!
    
    
    override func viewDidLoad() {
        _vBackView.layer.masksToBounds = true
        _vBackView.layer.cornerRadius = CGFloat(10.0)
    }

    @IBAction func onConfirmClicked(sender: UIButton) {
        Snake.sharedInstance.guestLogin(transparent: self.context.transparent) {( _ :Result<SnakeUserInfo>)->Void in}
    }
  
    @IBAction func onReturnClicked(sender: UIButton) {
        self.dismiss(animated: true)
    }

}
