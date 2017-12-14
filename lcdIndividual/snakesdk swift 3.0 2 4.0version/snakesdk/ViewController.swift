//
//  ViewController.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit






//1.
class ViewController: UIViewController {
    

    
    @IBAction func onLoginClicked(sender: AnyObject) {
            
        Snake.sharedInstance.setLoginCallback(login: LoginCallback(
            onSuccess: { userInfo, transparent in
                print("\(userInfo.description)",transparent ?? "")
                
                Snake.sharedInstance.setExtras(game: "花千骨", roleId: "1", roleName: "杀千陌", serverId: "2", serverName: "主宰霸业")
            },
            
            onFailed: { error, transparent in
                print(error, transparent ?? "")
        }))
        
        Snake.sharedInstance.setAccountSwitchCallback(accountSwitch: AccountSwitchCallback(
            onSwitch: {
                print("logout")
                Snake.sharedInstance.login(transparent: "abcd" as AnyObject?)
            
            }))
        
        
        Snake.sharedInstance.setPayCallback(pay: PayCallback(
            onSuccess: { transparent in
                Snake.sharedInstance.setExtras(game: "花千骨", roleId: "1", roleName: "杀千陌", serverId: "2", serverName: "主宰霸业")
            },
            
            onFailed: { error, transparent in
                print(error, transparent ?? "")
        }))
        
        Snake.sharedInstance.login(transparent: "abcd" as AnyObject?)
        
    }
    
    @IBAction func onLogoutClicked(sender: AnyObject) {
        Snake.sharedInstance.switchAccount()
    }
    
    @IBAction func onUserCenterClicked(sender: AnyObject) {
        Snake.sharedInstance.userCenter(transparent: "abcd" as AnyObject?)
    }
    
    @IBAction func onPayClicked(sender: AnyObject) {
        Snake.sharedInstance.pay(count: 1, totalAmount: 1, productID: "123456", productName: "58同城", productDesc: "这是一个神奇的网站", notifyURL: "http://a.b.c", transparent: "haha" as AnyObject?)
    }
    
    override func viewDidLoad() {
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "game_Background")!) 
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func _onQuitClicked(sender: UIButton) {
       Snake.sharedInstance.quit(hasExitGame: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

