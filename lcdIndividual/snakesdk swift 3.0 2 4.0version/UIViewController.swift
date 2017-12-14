//
//  UIViewController.swift
//  snakesdk
//
//  Created by tgame on 16/6/30.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit
//: UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning
extension UIViewController {
    class func topMostViewController() -> UIViewController? {
        return UIViewController.topViewControllerForRoot(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    class func topViewControllerForRoot(rootViewController:UIViewController?) -> UIViewController? {
        
        guard let rootViewController = rootViewController else {
            return nil
        }
        
        guard let presented = rootViewController.presentedViewController else {
            return rootViewController
        }
        
        switch presented {
        case is UINavigationController:
            let navigationController:UINavigationController = presented as! UINavigationController
            return UIViewController.topViewControllerForRoot(rootViewController: navigationController.viewControllers.last)
            
        case is UITabBarController:
            let tabBarController:UITabBarController = presented as! UITabBarController
            return UIViewController.topViewControllerForRoot(rootViewController: tabBarController.selectedViewController)
            
        default:
            return UIViewController.topViewControllerForRoot(rootViewController: presented)
        }
    }
    
    ///http://stackoverflow.com/questions/2798653/is-it-possible-to-determine-whether-viewcontroller-is-presented-as-modal/16764496#16764496
    var isPresentedAsModal: Bool {
        // If we are a child view controller, we need to check our parent's presentation
        // rather than our own.  So walk up the chain until we don't see any parentViewControllers
        var  potentiallyPresentedVC : UIViewController = self
        
        while potentiallyPresentedVC.parent != nil {
            potentiallyPresentedVC = potentiallyPresentedVC.parent!
        }
        
        if self.presentingViewController?.presentedViewController == potentiallyPresentedVC {
            return true
        }
        
        if (self.navigationController?.presentingViewController?.presentedViewController == self.navigationController ) &&
            self.navigationController?.viewControllers[0] == self{
            return true
        }
        
        return potentiallyPresentedVC.tabBarController?.presentingViewController is UITabBarController
    }
    func dismissViewController(vcName: AnyClass){
        var vc: UIViewController = self
        while vc.isKind(of: vcName) {
            vc = vc.presentingViewController!
        }
        vc.dismiss(animated: true)
    }
    
        
}
