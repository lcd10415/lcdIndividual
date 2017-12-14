//
//  PhoneSuccessSettedViewController.swift
//  snakesdk
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class PhoneSuccessSettedViewController: UIViewController {
    
    var context: Context!

    @IBOutlet weak var _btnReturnLogin: UIButton!
    @IBAction func onConfirmClicked(sender: UIButton) {
        
         self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notification.PhoneNumberChanged), object: nil, userInfo: ["text":context.phone!])
        
    }
    @IBAction func onReturnClicked(sender: UIButton) {
        self.parent?.parent?.parent?.parent?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Meta.setBtnCornerRadius(_btnReturnLogin)
        
        // Do any additional setup after loading the view.
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
