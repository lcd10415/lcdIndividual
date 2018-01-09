//
//  ViewController.swift
//  ReSideMenu
//
//  Created by ReleasePackageMachine on 2017/12/28.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let sideVC = SideMenuViewController()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = UIScreen.main.bounds.size.width;
        let height = UIScreen.main.bounds.size.height;
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(self.onLeftClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .plain, target: self, action: #selector(self.onRightClicked))
        self.title = "Home"
        self.view.backgroundColor = UIColor.green

        sideVC.view.frame = CGRect(x:-width,y:0,width:width,height:height)
        self.addChildViewController(sideVC)
        self.view.addSubview(sideVC.view)
        self.view.bringSubview(toFront: sideVC.view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func onLeftClicked(sender: UIBarButtonItem) {
        count = count + 1
        let width = UIScreen.main.bounds.size.width;
        let height = UIScreen.main.bounds.size.height;
        weak var weakSelf = self
        if count%2 != 0 {
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf?.navigationController?.view.transform = CGAffineTransform.init(translationX: width/2, y: 0)
                
//                weakSelf?.view.center = CGPoint(x:width/2,y:height/2)
//                weakSelf?.view.bringSubview(toFront: (weakSelf?.sideVC.view!)!)
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf?.navigationController?.view.transform = CGAffineTransform.identity
//                weakSelf?.view.center = CGPoint(x:0,y:height/2)
            })
            
        }
        
        
        print("left")
    }
    @objc func onRightClicked() {
        count = count + 1
        let width = UIScreen.main.bounds.size.width;
        let height = UIScreen.main.bounds.size.height;
        weak var weakSelf = self
        if count%2 != 0 {
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf?.navigationController?.view.transform = CGAffineTransform.init(translationX: -width/2, y: 0)
                //                weakSelf?.view.center = CGPoint(x:width/2,y:height/2)
                //                weakSelf?.view.bringSubview(toFront: (weakSelf?.sideVC.view!)!)
            })
        }else{
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf?.navigationController?.view.transform = CGAffineTransform.identity
                //                weakSelf?.view.center = CGPoint(x:0,y:height/2)
            })
            
        }
        print("right")
    }

}

