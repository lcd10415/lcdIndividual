//
//  payment.swift
//  snakesdk
//
//  Created by tgame on 16/8/4.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import Foundation

public class Payment {
    
    private var _payBy : PayBy!
    public var payBy: PayBy {
        set {
            _payBy = newValue
        }
        get {
            return _payBy
        }
    }
    
    static let sharedInstance = Payment()
    private init() {}
    
    /*! @brief 发送请求到微信，等待微信返回onResp
     *
     * 函数调用后，会切换到微信的界面。第三方应用程序等待微信返回onResp。微信在异步处理完成后一定会调用onResp。支持以下类型
     * SendAuthReq、SendMessageToWXReq、PayReq等。
     * @param req 具体的发送请求，在调用函数后，请自己释放。
     * @return 成功返回YES，失败返回NO。
     */
    func payByWeChat(params: [String: AnyObject]) {
        
        let request = PayReq()

        request.partnerId = params["partnerId"] as! String
        request.prepayId = params["prepayId"] as! String
        request.nonceStr = params["nonceStr"] as! String
        request.sign = params["sign"] as! String
        request.package = "Sign=WXPay"
        request.timeStamp = UInt32(params["timeStamp"] as! String)!
        
        WXApi.send(request)
    }
    
    //todo: error
    func payByAliPay(params: String, sign: String, signType: String, callback: @escaping (_ result: PayResult)->Void) {
        
        let order = "\(params)&sign=\"\(sign)\"&sign_type=\"\(signType)\""
        AlipaySDK.defaultService().payOrder(order, fromScheme: Constant.AppScheme) {/*[unowned self]*/ result in
            let dict = result as [AnyHashable:Any]?
            
            var res : PayResult
            
            if let status = dict?["resultStatus"] as? String {
                switch AliPayResult(rawValue: status)!{
                case .Success:
                    res = PayResult.Success
                    
                case .Cancel:
                    res = PayResult.Cancel
                    
                default:
                    res = PayResult.Failed
                    
                }
                
                callback( res)
                
            }   // end of if let status = res["resultStatus"] {
 
        
        }
    }
    
    
    /*
     
     华夏银行贷记卡：6226 3880 0000 0095
         手机号：18100000000
         CVN2：248
         有效期：1219
         短信验证码：123456（先点获取验证码之后再输入）
         证件类型：01身份证
         证件号：510265790128303
         姓名：张三
     */
    func payByUnionPay(tn: String, mode: UnionpayMode, viewController: UIViewController) {
        
        //todo: err log
        let result = UPPaymentControl.default().startPay(tn, fromScheme: Constant.AppScheme, mode: mode.rawValue, viewController: viewController)
        print("\(result)")
    }
    
    func handlePaymentResult( url: NSURL) {
        
        switch Payment.sharedInstance.payBy {
        case .AliPay:
            AlipaySDK.defaultService().processOrder(withPaymentResult: url as URL, standbyCallback: { (result:[AnyHashable : Any]?) in
                let dict = result! as Dictionary
                
                var res : PayResult
                
                if let status = dict["resultStatus"] as? String {
                    switch AliPayResult(rawValue: status)!{
                    case .Success:
                        res = PayResult.Success
                        
                    case .Cancel:
                        res = PayResult.Cancel
                        
                    default:
                        res = PayResult.Failed
                        
                    }
                    NotificationCenter.default.post(name:NSNotification.Name(rawValue:Notification.PayResult), object: res.rawValue)
                }
            })
        case .UnionPay:
            UPPaymentControl.default().handlePaymentResult(url as URL, complete: { (code: String?, result:[AnyHashable : Any]?) in
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:Notification.PayResult), object: code!)
            })
        default:
            break;
        }
        
    }
    
}

