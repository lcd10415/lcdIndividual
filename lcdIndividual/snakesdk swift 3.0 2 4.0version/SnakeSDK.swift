//
//  BridgeSwift.swift
//  Unity-iPhone
//
//  Created by mac on 16/8/30.
//
//

import Foundation
import UIKit

@objc class SnakeSDK: NSObject {
    
    static let shareInstace = SnakeSDK()
    private override init() {}
    
    struct PayOrder {
        var count:Int = 0
        var totalAmount:Int = 0
        var productID: String = ""
        var productName: String = ""
        var productDesc: String = ""
        var notifyURL: String = ""
        var transparent: String = ""
    }
    
    struct GameRole {
        var game: String = ""
        var roleId: String = ""
        var roleName: String = ""
        var serverId: String = ""
        var serverName: String = ""
        var gameUserBalance: String = ""
        var vipLevel: String = ""
        var gameUserLevel: String = ""
        var partyName: String = ""
    }
    

    internal func onLoginClickBySwift(trans: String?){
        Snake.sharedInstance.login(transparent: trans as AnyObject)
    }
    
    internal func onLoginOutClickBySwift(){
        Snake.sharedInstance.switchAccount()
    }
    
    internal func onUserCenterClickBySwift(trans: String?){
        Snake.sharedInstance.userCenter(transparent: trans as AnyObject)
        
    }
    
    internal func onPayClickBySwift(count: Int,totalAmount: Float32,productID: String,productName: String,productDesc: String,notifyURL: String,transparent: String){
//        Meta.suspendWindow()!.isHidden = true
        Snake.sharedInstance.pay(count: count, totalAmount: Int(totalAmount*100), productID: productID, productName: productName, productDesc: productDesc, notifyURL: notifyURL, transparent: transparent as AnyObject)
       
    }
    
    
    internal func onExitClickBySwift(){
        Snake.sharedInstance.quit(hasExitGame: true)
    }
    
    internal func setExtras(game: String,roleId: String,roleName: String,serverId: String,serverName: String,gameUserBalance: String,vipLevel: String,gameUserLevel: String,partyName: String){
        Snake.sharedInstance.setExtras(game: game, roleId: roleId, roleName: roleName, serverId: serverId, serverName: serverName, gameUserBalance: gameUserBalance,vipLevel: vipLevel,gameUserLevel: gameUserLevel,partyName: partyName)
    }
    
    func verifyAPPStoreIAP(receipt: String,
                           orderId: String,
                           productId: String?,
                           transactionId: String?,
                           completion:  @escaping (Int, Bool)-> Void ) {
//        Snake.sharedInstance.verifyAPPStoreIAP(receipt: receipt, orderId: orderId, productId: productId, transactionId: transactionId, completion: completion)
    }
    
    
    internal func handlePaymentResult(url: NSURL){
        Snake.sharedInstance.handlePaymentResult(url: url)
    }
    
    internal func sdkInitCallBack(){
        Snake.sharedInstance.setLoginCallback(login: LoginCallback(
            onSuccess: { userInfo, transparent in
                let headers = [
      
                    "Content-Type": "application/json;charset=UTF-8"
                ]
                
                let params = JSONND(dictionary: ["token": userInfo.token])
                
                http.Post(url: http.UserLoginCheckURL, params: params, headers:headers) { [unowned self] data, error in
                    
                    if let _ = error {
                         //todo error
//                        BridgeObjectiveC.sendU3dMessage("onLoginFailed",param: ["trans":"登录失败"])
                        return
                        
                    }
                    let uuid = (data!["uuid"]).data
                    let sign = (data!["sign"]).data
//                    BridgeObjectiveC.sendU3dMessage("onLoginSuccess",param: ["data":["uuid":uuid,"sign":sign],
//                                                                             "token":userInfo.token])
                }
            },
            
            onFailed: { error, transparent in
//                BridgeObjectiveC.sendU3dMessage("onLoginFailed",param: ["trans":"登录失败"])
        }))
        
        Snake.sharedInstance.setAccountSwitchCallback(accountSwitch: AccountSwitchCallback(
            onSwitch: {
//                BridgeObjectiveC.sendU3dMessage("onLogoutSuccess",param: ["trans":""])
//                Snake.sharedInstance.login(transparent: "" as AnyObject)
    
        }))
        
        
        Snake.sharedInstance.setPayCallback(pay: PayCallback(
            onSuccess: { transparent in
                let params = ["trans":transparent!]
//                BridgeObjectiveC.sendU3dMessage("onPaySuccess",param: params)
        },
            
            onFailed: { error, transparent in
                let params = ["error": error,
                              "trans": transparent!] as [String : Any]
//                BridgeObjectiveC.sendU3dMessage("onPayFailed", param: params)

        }))
        
        Snake.sharedInstance.setExitCallback(exit: ExitCallback(
            onExit:{
//                BridgeObjectiveC.sendU3dMessage("OnExitResult",text: OPResult.Yes.rawValue)
            }))
        
//        Snake.sharedInstance.setLogoutCallback(logout: LogoutCallback(
//            onLogout:{
//                BridgeObjectiveC.sendU3dMessage("OnLogoutCompleted",text: OPResult.Yes.rawValue)
//        }))
        
    }
    
}
