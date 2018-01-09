//
//  LCDSideController.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/5.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class LCDSideController: LCDBasicController,UIGestureRecognizerDelegate {
    var leftVC : LCDBasicController!
    var mainVC : UIViewController!
    var startPan :UIScreenEdgePanGestureRecognizer!
    var sidePan  :UIPanGestureRecognizer!
    var tap      :UITapGestureRecognizer!
    var maskView :UIView! //
    
    
    init(frame:CGRect,left: LCDBasicController,main: UIViewController) {
        self.init(frame: frame)
        self.leftVC = left
        self.mainVC = main
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupUI(){
        self.view.addSubview(self.leftVC.view)
        self.view.addSubview(self.mainVC.view)
        self.addChildViewController(leftVC)
        self.addChildViewController(mainVC)
        self.mainVC.didMove(toParentViewController: self)
        self.leftVC.didMove(toParentViewController: self)
        
        self.leftVC.view.frame = self.view.frame
        self.mainVC.view.frame = self.view.frame
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.addSubview(self.maskView)
        
        mainVC.view.addGestureRecognizer(startPan)
        mainVC.view.addGestureRecognizer(sidePan)
        mainVC.view.addGestureRecognizer(tap)
    }
    
    func screenGesture(pan: UIPanGestureRecognizer) {
        let point = pan.translation(in: pan.view)
        let verPoint = pan.velocity(in: pan.view)
        
        
        
    }
    enum TemperatureUnit: Character{
        case kelvin = "K",celsius = "C", fahrenheit = "F"
    }
    
    
    //关闭抽屉
    func closeDrawer() {
        let fah = TemperatureUnit(rawValue: "F")
        if fah != nil {
            print("This is fah")
        }
        let cel = TemperatureUnit(rawValue: "C")
        if cel != nil {
            print("this is a cel unit")
        }
        
        
    }
    
    //打开抽屉
    func openDrawer()  {
        
    }
    
}
