
//
//  AppDelegate.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//

/*

 */
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate{

    var window: UIWindow?


    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        if let dict = try? Dictionary<String, AnyObject>.loadPlistFromBundle(filename: Constant.ConfigPlist) {
            let WX_AppID: String = dict["weixin_AppID"] as! String
            WXApi.registerApp(WX_AppID, withDescription: "snakesdk")
        }
        return true
    }
    
    func onResp(_ resp: BaseResp!) {
        //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
        if resp.isKind(of: SendAuthResp.self) {
            let response = resp as! SendAuthResp
            switch response.errCode {
            case 0:
                let dict: Dictionary<String,String> = ["code":response.code]
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:Notification.WechatLogined), object: nil, userInfo: dict as [AnyHashable : Any]?)
            case -2:
                Utils.localShowToast(message: "userCancel".localized)
            case -4:
                Utils.localShowToast(message: "userRefusedAuth".localized)
            default:
                break
            }
        }
        /*
        if resp.isKindOfClass(PayResp) {
            var resultValue: String
            switch resp.errCode {
            case 0:
                //success
                resultValue = "success"
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.WechatPayed, object: resultValue)
            case -2:
                //userCancel
                resultValue = "cancel"
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.WechatPayed, object: resultValue)
            default:
                //fail
                resultValue = "fail"
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.WechatPayed, object: resultValue)
            }
        }*/
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        Snake.sharedInstance.handlePaymentResult(url: url as NSURL)
//        WXApi.handleOpenURL(url, delegate: self)
        
        return true
    }
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
   
       
        WXApi.handleOpen(url as URL!, delegate: self)
        return true
    }
}

