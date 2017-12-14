 //
//  snake.swift
//  snakesdk
//
//  Created by tgame on 16/6/30.
//  Copyright © 2016年 snakepop. All rights reserved.
//
import UIKit


public class Snake {
    private var _rootCtx = Context()
    
    static let sharedInstance = Snake()
    private init() {}
    
    
    // MARK: - Public APIs
    
    //设置登录回调
    public func setLoginCallback(login: LoginCallback) {
        SnakeCallback.sharedInstance.login = login
    }
    
    //设置账户切换回调
    public func setAccountSwitchCallback(accountSwitch: AccountSwitchCallback) {
        SnakeCallback.sharedInstance.accountSwitch = accountSwitch
        
    }
    
    //设置支付回调
    public func setPayCallback(pay: PayCallback) {
        SnakeCallback.sharedInstance.pay = pay
        
    }
    
    //设置退出的回调
    public func setExitCallback(exit:ExitCallback){
        SnakeCallback.sharedInstance.exit = exit
    }
    
    
    //设置账户额外信息
    public func setExtras( game: String = "", roleId: String = "", roleName: String = "", serverId: String = "", serverName: String = "",gameUserBalance: String = "", vipLevel: String = "", gameUserLevel: String = "", partyName: String = "") {
        
        let role = RoleInfo(game: game, roleID: roleId, roleName: roleName, serverID: serverId, serverName: serverName,gameUserBalance: gameUserBalance,vipLevel: vipLevel,gameUserLevel: gameUserLevel,partyName: partyName)
        
        _rootCtx.role = role
    }
    
    //登录
    public func login( transparent: AnyObject?) {
        if Utils.canAutoLogin() {
            _autoLogin(transparent: transparent)
            
            return
        }
        _presentLoginVC(transparent: transparent)
        
    }
    
    //账户切换
    public func switchAccount() {
        guard Cache.sharedInstance.currentUserType != nil else {
            return
        }
        
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        
        http.Post(url: http.LogoutURL, headers:headers) { [unowned self] data, error in
            
            if let err = error {
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "switchAccount",
                    "error":     err,
                    ])
                
                
            }
            Utils.clearCurUser()
            Utils.skipShowToast(message: "accountLogout".localized)
            SnakeCallback.sharedInstance.accountSwitch?.onSwitch()
            
        }
        
    }
    
    
    //此transparent值是用于当用户尚未登录而又点击了用户中心
    //后由sdk发起的登录操作时用
    public func userCenter(transparent: AnyObject?) {
        if !Utils.isOnline() {
            _presentLoginVC(transparent: transparent)
            return
        }
        
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "UserCenterViewController") as? UserCenterViewController else {
            return
        }
        
        vc.context = _rootCtx
        vc.context.transparent = transparent
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
        
        
    }
    
    
    //支付
    public func pay(
        count:       Int,
        totalAmount: Int,
        productID:   String,
        productName: String,
        productDesc: String,
        notifyURL:   String,
        transparent: AnyObject?) {
        
        if !Utils.isOnline() {
            _presentLoginVC(transparent: transparent)
            return
        }
        
        let params = PaymentInfo(
            count:       count,
            amount:      totalAmount,
            productID:   productID,
            productName: productName,
            productDesc: productDesc,
            notifyURL:   notifyURL,
            transparent: transparent)
        
        
        Snake.sharedInstance.accountBalance() { [unowned self ] (balance: Int, ok: Bool) -> Void in
            
            if !ok {
                //todo
            }
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "IAPViewController") as? IAPViewController else {
                return
            }
            
            self._rootCtx.account = Cache.sharedInstance.currentUser
            
            vc.context = self._rootCtx
            vc.context.payment = params
            
            //余额
            vc.context.any = balance
            
            UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - Internal APIs
    
    //游客登录
    func guestLogin(transparent: AnyObject?, completion: @escaping  LoginCompletion) {
        let params = makeLoginDict(
            channelID: Config.sharedInstance.channelID,
            appID:     Config.sharedInstance.appID)
        
        _loginOrRegisterHelper(
            url: http.LoginURL,
            params:      params,
            transparent: transparent,
            completion:  completion)
        
    }
    
    //手机注册
    func phoneRegister(context :Context, verifyCode: String  ) {
        
        let params = makeLoginDict(
            type: RegisterOrVerifyBy.Phone.rawValue,
            channelID:  Config.sharedInstance.channelID,
            appID:      Config.sharedInstance.appID,
            verifyCode: verifyCode.trim(),
            phone:      context.phone!.trim() )
        
        _loginOrRegisterHelper( url: http.RegisterURL,
            params:      params,
            transparent: context.transparent)
    }
    
    
    
    
    //手机登录
    func phoneLogin(context: Context, password: String = "", verifyCode: String = ""  ) {
        let params = makeLoginDict(
            type: LoginBy.Phone.rawValue,
            channelID:  Config.sharedInstance.channelID,
            appID:      Config.sharedInstance.appID,
            password:   password.trim(),
            verifyCode: verifyCode.trim(),
            phone:      context.phone!.trim() )
        
        _loginOrRegisterHelper(
            url: http.LoginURL,
            params:      params,
            transparent: context.transparent)
        
        
    }
    
    //贪玩蛇注册
    func snakeRegister( context: Context, verifyCode: String ) {
        let params = makeLoginDict(
            type: RegisterOrVerifyBy.Snake.rawValue,
            channelID: Config.sharedInstance.channelID,
            appID:     Config.sharedInstance.appID,
            name:      context.account!.trim(),
            password:  context.password!.trim(),
            verifyCode: verifyCode.trim(),
            phone:     context.phone!.trim() )
        
        _loginOrRegisterHelper(
            url: http.RegisterURL,
            params: params,
            transparent: context.transparent)
        
    }
    
    //贪玩蛇登录
    func snakeLogin( context: Context) {
        let params = makeLoginDict(
            type: LoginBy.Snake.rawValue,
            channelID: Config.sharedInstance.channelID,
            appID:     Config.sharedInstance.appID,
            name:      context.account!.trim(),
            password:  context.password!.trim())
        
        _loginOrRegisterHelper(
            url: http.LoginURL,
            params:      params,
            transparent: context.transparent)
        
    }
    
    //贪玩蛇绑定
    func snakeBinding( context: Context){
        let params = makeBindindDict(
            name: context.account!.trim(),
            password: context.password!.trim(),
            appid: Config.sharedInstance.appID)
        _bindingSnakeHelper(url: http.BindURL, params: params,transparent: context.transparent)
    }
    
    //贪玩蛇注册并绑定
    func snakeRegisterAndBinding( context: Context, verifyCode: String ) {
        let params = makeLoginDict(
            type: 4,
            channelID: Config.sharedInstance.channelID,
            appID:     Config.sharedInstance.appID,
            name:      context.account!.trim(),
            password:  context.password!.trim(),
            verifyCode: verifyCode.trim(),
            phone:     context.phone!.trim() )
        
        _bindingSnakeHelper(
            url: http.RegisterURL,
            params: params,
            transparent: context.transparent)
        
    }

    
    
    //第三方登录
    func thirdPartyLogin(context:Context,code:String,platform:String){
        let params = makeAutoLoginDict(
            type: ThirdPartyLoginBy.Manual.rawValue,
            channelID: Config.sharedInstance.channelID,
            appID: Config.sharedInstance.appID,
            code:code,
            platform:platform,
            sn: "",
            cipher: ""
        )
        _loginOrRegisterHelper(
            url: http.ThirdLoginURL,
            params:     params,
            transparent: context.transparent)
    }
    
    //获取手机验证码
    func fetchVerifyCode(context: Context, type: VerifyCodeBy ) {
        let params = makeFetchVerifyCodeDict(
            type: type,
            phone: context.phone ?? "",
            name:  context.account ?? "")
        _fetchVerifyCodeHelper(params: params, transparent: context.transparent)
        
    }
    
    //获取图形验证码
    func fetchCaptcha( context:    Context,
                       width:      Int,
                       height:     Int,
                       completion: @escaping (NSData?, String?, Bool)-> Void ) {
        
        let params = makeFetchCaptchaDict(width: width, height: height)
        
        let closer = Utils.showLoading()
        
        var ok = false
        var verifyID: String?
        var raw: NSData?
        
        http.Post( url: http.CaptchaURL, params: params) { [unowned self] data, error in
            defer {
                closer()
                completion(raw, verifyID, ok )
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "fetchCaptcha",
                    "width":     width,
                    "height":    height,
                    "error":     error,
                    ])
                return
            }
            
            ok = true
            verifyID = data!["verify_id"].stringValue
            raw = NSData(base64Encoded:data!["image"].stringValue, options: .ignoreUnknownCharacters )
            
        }
        
    }
    
    
    //查询用户信息
    func queryUserInfo(context: Context,  completion:@escaping (String?, Bool) -> Void) {
        let params = makeQueryUserInfoDict(name: context.account!)
        
        let closer = Utils.showLoading()
        
        var ok = false
        var phone: String?
        
        http.Post( url: http.UserInfoQueryURL, params: params) { [unowned self] data, error in
            defer {
                closer()
                completion(phone, ok )
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "queryUserInfo",
                    "error":     error,
                    ])
                
                return
            }
            
            phone = data!["masked_phone"].stringValue
            ok = true
            
        }// end of http.Post
        
    }
    
    //验证短信验证码
    func verifySMSCode(
        context:    Context,
        type:       VerifyCodeBy,
        code:       String,
        completion: @escaping (String?, Bool ) -> Void) {
        
        let params = makeVerifySMSCodeDict(
            type: type.rawValue,
            name:  context.account!,
            phone: context.phone!,
            code:  code)
        
        var ok = false
        var ret: String?
        
        let closer = Utils.showLoading()
        
        http.Post( url: http.SMSCodeVerifyURL, params: params) { [unowned self] data, error in
            defer {
                closer()
                completion(ret, ok )
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "verifySMSCode",
                    "error":     error,
                    "type":      type,
                    "code":      code,
                    ])
                
                return
            }
            
            ok = true
            ret = data!.stringValue
            
        }
        
    }
    
    
    //生成IAP订单
    func genIAPOrder(
        context: Context,
        type:    OrderType,
        payBy:   PayBy,
        completion:   @escaping ([String:String]?, Bool)-> Void ) {
        
        let p = context.payment!
        _genOrderHelper(
            type: type,
            payBy:        payBy,
            money:        p.amount,
            realMoney:    p.amount,
            productID:    p.productID,
            productName:  p.productName,
            productCount: p.count,
            productExtra: p.productDesc,
            notifyURL:    p.notifyURL,
            role:         context.role,
            completion:   completion)
        
    }
    
    
    //生成充值订单
    func genRechargeOrder(
        context: Context,
        type:    OrderType,
        payBy:   PayBy,
        productID:    String,
        completion:  @escaping ([String:String]?, Bool)-> Void ) {
        _genOrderHelper(
            type: type,
            payBy:      payBy,
            productID:  productID,
            role:       context.role,
            completion: completion)
        
    }
    
    
    //更新用户信息
    func updateUserInfo( context: Context, type: ModifyInfo, verifyCode: String = "", completion:@escaping (Bool)->Void) {
        
        let params = makeUpdateUserDict(type: type.rawValue,
                                        appID:        Config.sharedInstance.appID,
                                        name:         context.account ?? "",
                                        phone:        context.phone ?? "",
                                        password:     context.password ?? "",
                                        prevVerifyID: context.any as! String,
                                        verifyCode: verifyCode)
        
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        
        let closer = Utils.showLoading()
        
        var ok = false
        var output = ""
        
        
        http.Put( url: http.UpdateURL, params: params, headers: headers) { [unowned self] data, error in
            defer {
                closer()
                completion(ok)
                Utils.localShowToast(message: output)
            }
            
            if let err = error {
                output = err
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "updateUserInfo",
                    "error":     error ?? "",
                    "type":      type ,
                    "phone":     context.phone ?? "",
                    "name":      context.account ?? "",
                    ])
                
                
                return
            }
            
            if Utils.curUserType() == .Phone {
                Cache.sharedInstance.currentUser = context.phone
            }
            else {
                Cache.sharedInstance.currentUser = context.account
            }
            
            ok = true
            
            switch type.rawValue{
            case 1:
                output = "phoneSetSuccess".localized
            case 2:
                output = "passwordSetSuccess".localized
            case 3:
                output = "findPasswordSuccess".localized
            default:
                break
            }
            
            
        }// end of http.Post
        
    }
    
    
    //手机自动登录 todo: async error
    func phoneAutoLogin(transparent: AnyObject?, completion: @escaping LoginCompletion )  {
        _autoLoginHelper( by: LoginBy.PhoneAuto, transparent: transparent, completion: completion)
        
    }
    
    
    //贪玩蛇自动登录
    func snakeAutoLogin(transparent: AnyObject?, completion: @escaping LoginCompletion ) {
        _autoLoginHelper( by: LoginBy.SnakeAuto, transparent: transparent, completion: completion)
        
    }
    
    //第三方自动登录
    func thirdPartyAutoLogin(transparent: AnyObject?, completion: LoginCompletion) {
        guard let curUser = Cache.sharedInstance.currentUser else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "snake",
                "action":    "_autoLoginHelper",
                "error":     SnakeError.NotFound,
                "by":        ThirdPartyLoginBy.Auto,
                ])
            
            completion(.Failure(SnakeError.NotFound as! Error))
            return
        }
        
        if let user = Store.sharedInstance.user(account: curUser) {
            let sn = Utils.UUID()
            let cipher = Utils.sign(plain: sn, derString: user.key)
            let params = makeAutoLoginDict(
                type: ThirdPartyLoginBy.Auto.rawValue,
                channelID: Config.sharedInstance.channelID,
                appID: Config.sharedInstance.appID,
                code:Cache.sharedInstance.code!,
                platform:"wechat",
                sn: sn,
                cipher: cipher
            )
            
            _loginOrRegisterHelper(url: http.ThirdLoginURL, params: params, transparent: transparent)
        }
    }
    //检测手机用户信息
    func checkAccountInfo(
        context:    Context,
        type:       RegisterOrVerifyBy,
        verifyID:   String = "",
        verifyCode: String = "",
        completion: @escaping ( PhoneStatus, Bool )->Void) {
        
        let params = makeCheckAccountInfoDict(
            type: type.rawValue,
            name:       context.account ?? "",
            phone:      context.phone ?? "",
            verifyID:   verifyID,
            verifyCode: verifyCode,
            appid:      Config.sharedInstance.appID )
        
        _checkAccountInfoHelper(
            params: params,
            transparent: context.transparent,
            completion:  completion)
        
    }
    
    
    //账户余额
    func accountBalance(completion:@escaping (Int, Bool)->Void) {
        
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        
        let closer = Utils.showLoading()
        
        var balance = 0
        var ok = false
        http.Get(url: http.BalanceURL,  headers: headers ){ [unowned self] data, error in
            defer { //退出之前执行的操作
                closer()
                completion(balance, ok )
            }
            
            guard error == nil else {
                Utils.localShowToast(message: error!)
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "accountBalance",
                    "error":     error,
                    ])
                
                return
            }
            balance = data!.intValue
            ok = true
            
        }// end of http.Get
        
        
    }
    
    
    //商品列表
    func productions(completion:@escaping ([Production]?, Bool )->Void) {
        
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        
        let closer = Utils.showLoading()
        
        var productions: [Production]?
        var ok = false
        
        http.Get(url: http.ProductionURL,  headers: headers ){ [unowned self] data, error in
            defer {
                closer()
                completion(productions, ok)
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "productions",
                    "error":     error,
                    ])
                return
            }
            
            productions = [Production]();
            
            for p in data!.arrayValue {
                
                let g = Production(
                    id: p["production_id"].stringValue,
                    name: p["name"].stringValue,
                    price: p["price"].intValue,
                    realPrice: p["real_price"].intValue)
                
                productions!.append(g)
                
            }
            
            ok = true
        }
        
        
    }
    
    //处理支付结果
    func handlePaymentResult( url: NSURL) {
        Payment.sharedInstance.handlePaymentResult(url: url)
    }
    
    //MARK: - Fake gameserver, for testing
    
    //虚假游戏验证,测试用
    func fakeGameServerVerify( token: String ) {
        let params = makeFakeGameServerVerifyDict( appid: Config.sharedInstance.appID, token: token)
        http.Post( url: http.FakeGameServerVerifyURL, params: params )
        
    }
    
    //MARK: - feedback
    func crashlytics( message: String? = "", stacktrace: String? = "", extras: String? = "") {
        
        let params = makeFeedbackDict(
            appID: Config.sharedInstance.appID,
            channelID:   Config.sharedInstance.channelID,
            language:    Utils.language,
            application: Utils.application,
            message:     message ?? "",
            stacktrace:  stacktrace ?? "",
            extras:      extras ?? "")
        
        http.Post( url: http.CrashlyticskURL, params: params )
    }
    
    
    //MARK: - Implement details
    
    //自动登录helper
    private func _autoLoginHelper( by: LoginBy, transparent: AnyObject?, completion: @escaping LoginCompletion ){
        guard let curUser = Cache.sharedInstance.currentUser else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "snake",
                "action":    "_autoLoginHelper",
                "error":     SnakeError.NotFound,
                "by":        by,
                ])
            
            completion(.Failure(SnakeError.NotFound as! Error))
            return
        }
        
        var name = ""
        var phone = ""
        
        if let user = Store.sharedInstance.user(account: curUser) {
            
            let sn = Utils.UUID()
            let cipher = Utils.sign(plain: sn, derString: user.key)
            
            if by == .SnakeAuto {
                name = user.account
                
            } else if by == .PhoneAuto {
                phone = user.account
            }
            
            let params = makeLoginDict(
                type: by.rawValue,
                channelID: Config.sharedInstance.channelID,
                appID:     Config.sharedInstance.appID,
                name:   name,
                phone:  phone,
                sn:     sn,
                cipher: cipher)
            _loginOrRegisterHelper(url: http.LoginURL, params: params, transparent: transparent, completion: completion)
            return
        }
        
        completion(.Failure(SnakeError.Login as! Error))
        
    }
    
    private func _loginOrRegisterHelper(url: String, params: JSONND, transparent: AnyObject?, completion: LoginCompletion? = nil) {
        
        let closer = Utils.showLoading()
        
        http.Post( url: url, params: params) { [unowned self] data, error in
            var output: String = "loginFail".localized
            
            if let err = error {
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "_loginOrRegisterHelper",
                    "error":     err,
                    ])
                
                output = err
                SnakeCallback.sharedInstance.login!.onFailed(err, transparent)
                
                completion?(Result<SnakeUserInfo>.Failure(SnakeError.Login))
                closer()
                Utils.localShowToast(message: output)
                return
            }
            
            let token: String = data!["token"].stringValue
            let account: String = data!["account"].stringValue
            let type: Int =  data!["type"].intValue
            
            let userInfo = SnakeUserInfo(
                appID:     Config.sharedInstance.appID,
                channelID: Config.sharedInstance.channelID,
                token:     token)
            
            //异常情况：用户信息保存失败
            guard let err = Store.sharedInstance.addOrUpdateUser( old: account, key: data!["key"].stringValue, type: type) else {
                Cache.sharedInstance.currentUser = account
                Cache.sharedInstance.currentToken = token
                Cache.sharedInstance.currentUserType = type
                SnakeCallback.sharedInstance.login?.onSuccess(userInfo, transparent)
                
                // todo: will be delete
                Snake.sharedInstance.fakeGameServerVerify(token: token)
                let dict = params.data! as! NSDictionary
                if dict["type"] as! Int == 4 {
                    output = "Account Binding Success".localized
                }
                else {
                    output = account +  "welcomeToGame".localized
                }
                completion?(Result<SnakeUserInfo>.Success(userInfo))
                closer()
                Utils.skipShowToast(message: output)
                return
            }
            SnakeCallback.sharedInstance.login?.onFailed("\(err)", transparent)
            
            completion?(Result<SnakeUserInfo>.Failure(SnakeError.Login))
            
            
        }// end of http.Post
        
    }
    
    private func _bindingSnakeHelper(url:String,params: JSONND, transparent: AnyObject?, completion: LoginCompletion? = nil){
        
        let closer = Utils.showLoading()
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        http.Post(url: url, params: params,headers: headers) { [unowned self]data, error in
            var output = ""
            if let err = error{
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "_bindingSnakeHelper",
                    "error":     err,
                    ])
                
                output = err
//                SnakeCallback.sharedInstance.login!.onFailed(error: err, transparent: transparent)
                
                completion?(Result<SnakeUserInfo>.Failure(SnakeError.Login))
                closer()
                Utils.localShowToast(message: output)
                return
            }
            
            let token = data!["token"].stringValue
            let account = data!["account"].stringValue
            let type =  data!["type"].intValue
            
            let userInfo = SnakeUserInfo(
                appID:     Config.sharedInstance.appID,
                channelID: Config.sharedInstance.channelID,
                token:     token)
            
            //异常情况：用户信息保存失败
            guard let err = Store.sharedInstance.addOrUpdateUser( old: account, key: data!["key"].stringValue, type: type) else {
                Cache.sharedInstance.currentUser = account
                Cache.sharedInstance.currentToken = token
                Cache.sharedInstance.currentUserType = type
                
                SnakeCallback.sharedInstance.login?.onSuccess(userInfo, transparent)
                
                // todo: will be delete
                Snake.sharedInstance.fakeGameServerVerify(token: token)
                
                output = "Account Binding Success".localized
                completion?(Result<SnakeUserInfo>.Success(userInfo))
                closer()
                Utils.skipShowToast(message: output)
                return
            }
            SnakeCallback.sharedInstance.login?.onFailed("\(err)", transparent)
            
            completion?(Result<SnakeUserInfo>.Failure(SnakeError.Login))
        }
    }
    
    private func _fetchVerifyCodeHelper(params: JSONND, transparent: AnyObject?) {
        
        let closer = Utils.showLoading()
        
        http.Post( url: http.FetchVerifyCodeURL, params: params) { [unowned self] data, error in
            
            var output: String = ""
            defer {
                closer()
            }
            
            if let err = error {
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "_fetchVerifyCodeHelper",
                    "error":     err,
                    ])
                
                Utils.localShowToast(message: err)
                
            }
            
        }// end of http.Post
        
    }
    
    
    //检测用户信息helper
    private func _checkAccountInfoHelper(params: JSONND, transparent: AnyObject?, completion:@escaping ( PhoneStatus, Bool)->Void) {
        
        let closer = Utils.showLoading()
        
        var ok = false
        
        http.Post( url: http.UserInfoCheckURL, params: params) { [unowned self] data, error in
            var output: String = ""
            
            var status: PhoneStatus = .illegal
            
            defer {
                closer()
                completion(status, ok )
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "_checkAccountInfoHelper",
                    "error":     err,
                    ])
                
                return
            }
            
            ok = true
            
            //以下判定存在先后顺序
            //未在本平台注册过的手机号
            var pass = data!["had_registered"].boolValue
            if !pass {
                status = PhoneStatus.notRegistered
                return
            }
            
            //该手机已注册，第一次登录此游戏
            pass = (data?["had_login_app"])!.boolValue
            if !pass {
                status = PhoneStatus.firstLogin
                return
            }
            
            //该手机没有设置过密码
            pass = (data?["had_set_password"])!.boolValue
            if !pass {
                status = PhoneStatus.noPassword
                return
            }
            
            status = PhoneStatus.havePassword
            
        }
    }
    
    
    //显示login vc
    private func _presentLoginVC( transparent: AnyObject?) {
        
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateInitialViewController() as? LoginViewController else {
            return
        }
        
        vc.context = _rootCtx
        vc.context.transparent = transparent
        if #available(iOS 8.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            vc.modalPresentationStyle = .currentContext
        }
        UIViewController.topMostViewController()!.definesPresentationContext = true
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
        
    }
    
    private func _autoLogin( transparent: AnyObject?) {
        
        guard let type = Cache.sharedInstance.currentUserType else {
            _presentLoginVC(transparent: transparent)
            return
        }
        
        let f = { [unowned self ]  (result: Result<SnakeUserInfo>) ->Void in
            switch result {
            case Result.Failure( _):
                self._presentLoginVC(transparent: transparent)
                
            default:
                break
            }
        }
        
        
        switch LoginBy(rawValue: type)! {
        case .Guest:
            guestLogin(transparent: transparent,  completion: f )
            
        case .Phone:
            phoneAutoLogin(transparent: transparent, completion: f)
            
        case .Snake:
            snakeAutoLogin(transparent: transparent, completion: f)
        case .ThirdParty:
            thirdPartyAutoLogin(transparent: transparent,completion: f)
        default:
            print("placeholder")
        }
        
    }
    
    //由服务器生成签名后的订单
    private func _genOrderHelper(
        type:      OrderType,
        payBy:     PayBy,
        money:     Int = 0,
        realMoney: Int = 0,
        extra:     String = "",
        productID:    String,
        productName:  String = "",
        productCount: Int = 1,
        productExtra: String = "",
        notifyURL:    String = "",
        order_platform: String = "snake",
        role: RoleInfo?,
        completion: @escaping ([String:String]?, Bool )-> Void ) {
        
        let params = makeGenSignedOrderDict(type: type.rawValue,
                                            appID:     Config.sharedInstance.appID,
                                            channelID: Config.sharedInstance.channelID,
                                            payBy:     payBy.rawValue,
                                            extra:     extra,
                                            money:     money,
                                            realMoney: realMoney,
                                            roleID:    role?.ID,
                                            roleName:  role?.Name,
                                            serverID:   role?.serverID,
                                            serverName: role?.serverName,
                                            productID:    productID,
                                            productCount: productCount,
                                            productName:  productName,
                                            productExtra: productExtra,
                                            order_platform: order_platform,
                                            notifyURL:    notifyURL)
        
        let headers = [
            "Authorization": "\(Cache.sharedInstance.currentToken!)",
            "Content-Type": "application/json;charset=utf-8"
        ]
        
        
        let closer = Utils.showLoading()
        var ok = false
        
        var result: [String:String]?
        
        http.PostRaw( url: http.GenSignedOrderURL, params: params, headers: headers) { [unowned self] response, error in
            defer {
                closer()
                completion(result, ok)
            }
            
            if let err = error {
                Utils.localShowToast(message: err)
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "snake",
                    "action":    "_genOrderHelper",
                    "error":     error ?? "",
                    "type":      type,
                    "realMoney": realMoney,
                    "productID": productID,
                    "notifyURL": notifyURL,
                    "roleID":    role?.ID ?? "",
                    "serverID":  role?.serverID ?? "",
                    "game":      role?.game ?? "",
                    "appID":     Config.sharedInstance.appID,
                    "channelID": Config.sharedInstance.channelID,
                    "payBy":     payBy,
                    ])
                
                return
            }
            
            result = [String:String]()
            ok = true
            
            switch Payment.sharedInstance.payBy {
                
            case .AliPay:
                result!["params"] = response!["params"].stringValue
                result!["sign"] = response!["sign"].stringValue
                result!["sign_type"] = response!["sign_type"].stringValue
                
                
            case .UnionPay:
                result!["tn"] = response!["transaction_no"].stringValue
                
            case .Snake:
                result!["result"] = response!["data"].stringValue
            case .WeChat:
                result!["partnerid"] = response!["partnerid"].stringValue
                result!["appid"] = response!["appid"].stringValue
                result!["prepayid"] = response!["prepayid"].stringValue
                result!["noncestr"] = response!["noncestr"].stringValue
                result!["sign"] = response!["sign"].stringValue
                result!["timestamp"] = response!["timestamp"].stringValue
            default:
                break
            }
            
            
        }// end of http.Post
    }
    
    
    public func quit(hasExitGame: Bool){
        
        if hasExitGame {
            guard let dstVC = UIStoryboard(name:"SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "ExitGameViewController") as? ExitGameViewController else {
                return
            }
            if #available(iOS 8.0, *) {
                dstVC.modalPresentationStyle = .overCurrentContext
            } else {
                dstVC.modalPresentationStyle = .currentContext
            }
            UIViewController.topMostViewController()!.definesPresentationContext = true
            UIViewController.topMostViewController()!.present(dstVC, animated: true, completion: nil)
        }
        
    }
}
