//
//  ExitGameViewController.swift
//  snakesdk
//
//  Created by mac on 2016/10/25.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class ExitGameViewController: UIViewController{
    @IBOutlet weak var _vBackVIew: UIView!
    
    override func viewDidLoad() {
        _vBackVIew.layer.masksToBounds = true
        _vBackVIew.layer.cornerRadius = CGFloat(10)
    }
    @IBAction func onCancelClicked(sender: UIButton) {
        self.dismiss(animated: true)
        
    }

    @IBAction func onGameCenterClicked(sender: UIButton) {
        guard let dstVC = UIStoryboard(name:"SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "AgreementViewController") as? AgreementViewController else {
            return
        }
        
        dstVC.identifier = "gameCenter"
        UIViewController.topMostViewController()!.present(dstVC, animated: true, completion: nil)
        
    }
    @IBAction func onExitClicked(sender: UIButton) {
        Utils.skipShowToast(message:"channelExit".localized)
        SnakeCallback.sharedInstance.exit?.onExit()
        exit(0)
    }
}
