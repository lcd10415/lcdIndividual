//
//  http.swift
//  snakesdk
//
//  Created by tgame on 16/6/30.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//import Pitaya

func makeDeviceDict() ->[String: AnyObject] {
    return [
        "model":  Utils.deviceType as AnyObject,
        "ip": Utils.IP as AnyObject,
        "os": Utils.OS as AnyObject,
        "imei": Utils.deviceID as AnyObject]
}

//获取验证码
func makeFetchVerifyCodeDict(type: VerifyCodeBy, phone: String, name: String ) -> JSONND {
    let dict = [
        "type":  type.rawValue as AnyObject,
        "name":  name,
        "phone": phone
    ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}


//获取图形验证码
func makeFetchCaptchaDict(width: Int, height: Int ) -> JSONND {
    let dict = [
        "width": width as AnyObject,
        "height": height,
    ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

//查询用户信息
func makeQueryUserInfoDict(name: String) -> JSONND {
    let dict = [
        "name": name as AnyObject,
        ]as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

func makeVerifySMSCodeDict(type: Int,  name: String = "", phone: String = "" , code: String) -> JSONND {
    let dict = [
        "type": type as AnyObject,
        "name": name,
        "phone": phone,
        "verify_code": code] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}



func makeCheckAccountInfoDict( type: Int, name: String, phone: String, verifyID: String, verifyCode: String, appid: String  ) -> JSONND {
    let dict = [
        "type": type as AnyObject,
        "name": name,
        "phone": phone,
        "verify_id": verifyID,
        "verify_code": verifyCode,
        "appid": appid,
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

func makeRegisterDict(type: Int, name: String, password: String, phone: String, appid: String, channelID: Int ) -> JSONND {
    
    let dict = [
        "type": type as AnyObject,
        "name": name,
        "password": password,
        "phone": phone,
        "appid": appid,
        "channel_id": channelID,
        "device": makeDeviceDict()
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}
func makeBindindDict(name: String,password: String,appid: String) -> JSONND {
    let dict = [
        "name":name as AnyObject,
        "appid": appid,
        "password": password,
        "device": makeDeviceDict()
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

//注册与登录 与 (首次、验证码、密码)登录走同一数据结构
func makeLoginDict(type:       Int = 1,
                   channelID:  String,
                   appID:      String,
                   code:       String = "",
                   platform:   String = "",
                   name:       String = "",
                   password:   String = "",
                   verifyCode: String = "",
                   phone:      String = "",
                   sn:         String = "",
                   cipher:     String = "",
                   isAdmin:    Bool = false)-> JSONND {
    
    
    let dict = [
        "type":        type as AnyObject,
        "platform":     platform,
        "channel_id":  channelID,
        "appid":       appID,
        "name":        name,
        "password":    password.md5(),
        "verify_code": verifyCode,
        "phone":       phone,
        "admin":       isAdmin,
        "device":      makeDeviceDict(),
        "code": code,
        "sn":     sn,
        "cipher":      cipher
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
    
}

func makeAutoLoginDict(type:       Int = 1,
                       channelID:  String,
                       appID:      String,
                       code:       String = "",
                       platform:   String = "",
                       name:       String = "",
                       password:   String = "",
                       verifyCode: String = "",
                       phone:      String = "",
                       sn:         String = "",
                       cipher:     String = "",
                       isAdmin:    Bool = false)-> JSONND {
    
    
    let dict = [
        "type":        type as AnyObject,
        "platform":     platform,
        "channel_id":  channelID,
        "appid":       appID,
        "name":        name,
        "password":    password.md5(),
        "verify_code": verifyCode,
        "phone":       phone,
        "admin":       isAdmin,
        "device": makeDeviceDict(),
        "data": [
            "code": code,
            "sn":     sn,
            "cipher":      cipher
        ]
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
    
}

func makeUpdateUserDict(type: Int = 1,
                        appID: String,
                        name: String = "",
                        phone: String = "",
                        password: String = "",
                        prevVerifyID: String = "",
                        verifyCode: String = "" )-> JSONND {
    let dict = [
        "type":     type as AnyObject,
        "appid": appID,
        "name": name,
        "password": password.md5(),
        "verify_code": verifyCode,
        "prev_verify_id": prevVerifyID,
        "phone": phone,
        "device": makeDeviceDict()
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
    
}

func makeGenSignedOrderDict(type: Int = 1,
                            appID: String,
                            channelID: String,
                            payBy: String,
                            extra: String,
                            money: Int,
                            realMoney: Int,
                            roleID: String?,
                            roleName: String?,
                            serverID: String?,
                            serverName: String?,
                            productID: String,
                            productCount: Int,
                            productName: String,
                            productExtra: String,
                            order_platform: String,
                            notifyURL: String) -> JSONND {
    
    let dict = [
        "type":  type as AnyObject,
        "appid": appID,
        "channel_id": channelID,
        "pay_platform": payBy,
        "extra": extra,
        "money": money,
        "real_money": realMoney,
        "role_id": roleID ?? "",
        "role_name": roleName ?? "",
        "server_id": serverID ?? "",
        "server_name": serverName ?? "",
        "product_id": productID,
        "product_name": productName,
        "product_count": productCount,
        "product_extra": productExtra,
        "notify_url": notifyURL,
        "order_platform":order_platform,
        "device": makeDeviceDict()
    ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

func makeFeedbackDict( appID:     String,
                       channelID: String,
                       language:  String,
                       application:  String,
                       message:    String,
                       stacktrace: String,
                       extras:     String) -> JSONND {
    
    let dict = [
        "platform":   "ios" as AnyObject,
        "appid":      appID,
        "channel_id": channelID,
        "language":   language,
        "message" :   message ,
        "stacktrace": stacktrace,
        "extra":      extras,
        "version":    application,
        "device":     makeDeviceDict()
        
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
    
    
}

func makeFakeGameServerVerifyDict(appid: String, token: String )-> JSONND {
    let dict = [
        "appid": appid as AnyObject,
        "token": token,
        ] as [String: Any]
    return JSONND(dictionary: dict as [String : AnyObject])
}

//微信发送预支付请求PrePay，再利用PrePay发送请求操作
func makeWeChatPrePayInfoDict(
                                partnerId: String,
                               appID:String,
                               prepayId:String,
                               nonceStr: String,
                               timeStamp: String,
                               sign: String  ) ->[String:AnyObject] {
    return [
        "partnerId": partnerId as AnyObject,
        "nonceStr": nonceStr as AnyObject,
        "timeStamp": timeStamp as AnyObject,
        "prepayId":prepayId as AnyObject,
        "appid":appID as AnyObject,
        "sign": sign as AnyObject,
        "device":makeDeviceDict() as AnyObject
        ]
}



struct http {
    static let codeOK = 0
    
//      private static let _passportBaseURL = "http://lg.1ktower.work:80/v1"
//    private static let _passportBaseURL = "http://lh.1ktower.work:8080/v1"
    private static let _passportBaseURL = "http://sdk.snakepop.com:8080/v1"
    
//          private static let _passportBaseURL = "http://10.10.30.238:8080/v1"
    
    //     private static let _passportBaseURL = "http://127.0.0.1:8080/v1"
    static let LoginURL = "\(_passportBaseURL)/user/login"
    static let ThirdLoginURL = "\(_passportBaseURL)/user/login/3rd"
    static let RegisterURL = "\(_passportBaseURL)/users/"
    static let BindURL = "\(_passportBaseURL)/users/binding"
    static let FetchVerifyCodeURL = "\(_passportBaseURL)/users/code/sms"
    static let CaptchaURL =  "\(_passportBaseURL)/users/code/captcha"
    static let UserInfoCheckURL = "\(_passportBaseURL)/users/check"
    static let UserInfoQueryURL = "\(_passportBaseURL)/users/q"
    static let SMSCodeVerifyURL = "\(_passportBaseURL)/users/code/verify"
    static let LogoutURL = "\(_passportBaseURL)/user/logout"
    static let UpdateURL =  http.RegisterURL
    //统计
    static let statisticsURL = "\(_passportBaseURL)/stats/sdk"
    static let CrashlyticskURL = "\(_passportBaseURL)/crashlytics"
    
    static let UserLoginCheckURL = "\(_passportBaseURL)/crashlytics"
    static let FakeGameServerVerifyURL = "http://snakepop.com:7070/verify"
    
    //    private static let _payBaseURL = "http://snakepop.com:9090/v1"
    static let BalanceURL = "\(_passportBaseURL)/order/balance"
    static let ProductionURL = "\(_passportBaseURL)/productions/"
    static let GenSignedOrderURL = "\(_passportBaseURL)/order/"
    
    static func Put(url: String, params: JSONND? = nil, headers: [String:String]? = nil, completion:@escaping (_ data: JSONND?, _ error: String?) -> Void =  { (_, _) in }) {
        
        _putOrPostHelper(method: .PUT, url: url, params: params, headers: headers, completion: completion)
        
    }
    static func Post(url: String, params: JSONND? = nil, headers: [String:String]? = nil , completion:@escaping (_ data: JSONND?, _ error: String?) -> Void =  { (_, _) in } ){
        
        _putOrPostHelper(method: .POST, url: url, params: params, headers: headers, completion: completion)
        
    }
    
    static func PostRaw(url: String, params: JSONND? = nil, headers: [String:String]? = nil , completion:@escaping (_ response: JSONND?, _ error: String?) -> Void =  { (_, _) in } ){
        _putOrPostRawHelper(method: .POST, url: url, params: params, headers: headers, completion: completion)
        
    }
    
    
    private static func _putOrPostHelper( method : HTTPMethod, url: String, params: JSONND?, headers: [String:String]?,completion:@escaping (_ data: JSONND? , _ error: String? ) -> Void) {
        
        let p = Pitaya.build(HTTPMethod: method, url: url)
        
        if headers != nil {
            for (key,value) in headers! {
                p.setHTTPHeader(Name: key, Value: value)
            }
        }
        
        
        if let body = params  {
           p.setHTTPBodyRaw(body.RAWValue)
        }
        
        
        p.onNetworkError({ (error) -> Void in
            completion(nil, error.localizedDescription)
        })
        
        
        p.responseJSON { (json, response) in
            guard json["code"].intValue == codeOK else  {
                completion(nil, errors.withCode(code: json["code"].intValue))
                return
            }
            
            completion(json["data"], nil)
            
        }
        
        
    }
    
    //此api为那些应答消息中无data字段的响应所用(多为支付相关)
    private static func _putOrPostRawHelper( method : HTTPMethod , url: String, params: JSONND?, headers: [String:String]?,completion:@escaping (_ response: JSONND?, _ error: String?) -> Void) {
        
        let p = Pitaya.build(HTTPMethod: method, url: url)
        
        if headers != nil {
            for (key,value) in headers! {
                p.setHTTPHeader(Name: key, Value: value)
            }
        }
        
        if let body = params  {
            p.setHTTPBodyRaw(body.RAWValue)
        }
        
        
            p.onNetworkError({ (error) -> Void in
            completion(nil, error.localizedDescription)
        })
        
        
            p.responseJSON { (json, response) in
            guard json["code"].intValue == codeOK else  {
                completion(nil, errors.withCode(code: json["code"].intValue))
                
                return
            }
            
            //            completion(response: json.optional("data"), error: nil)
            completion(json, nil)
        }
        
        
    }
    
    
    static func Get(url: String, params: JSONND? = nil, headers: [String:String]? = nil, completion:@escaping (_ data: JSONND?, _ error: String?) -> Void){
        
        let p = Pitaya.build(HTTPMethod: .GET, url: url)
        
        for (key,value) in headers! {
            p.setHTTPHeader(Name: key, Value: value)
        }
        
        if let body = params  {
            p.setHTTPBodyRaw(body.RAWValue)
        }
        
        
        p.onNetworkError({ (error) -> Void in
            completion(nil, error.localizedDescription)
        })
        
        
        p.responseJSON { (json, response) in
            guard json["code"].intValue == codeOK else  {
                completion(nil, errors.withCode(code: json["code"].intValue))
                return
            }
            
            completion(json["data"], nil)
            
        }
        
    }
    
    
}

