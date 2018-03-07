//
//  callback.swift
//  snakesdk
//
//  Created by tgame on 16/8/10.
//  Copyright © 2016年 snakepop. All rights reserved.
//


/* 登录成功、失败回调 */
typealias LoginSuccessHandler = ( _ userInfo: SnakeUserInfo, _ transparent: AnyObject? )->Void
typealias LoginFailedHandler = ( _ error: String, _ transparent: AnyObject? )->Void

//账户切换回调
typealias AccountSwitchHandler = ()->Void

/*支付成功、失败回调*/
typealias PaySuccessHandler = (_ transparent: AnyObject?)->Void
typealias PayFailedHandler  = (_ error: String, _ transparent: AnyObject?)->Void

//退出回调
typealias ExitHandler = ()->Void

//登录回调
public struct LoginCallback {
    private var _onSuccess : LoginSuccessHandler
    private var _onFailed : LoginFailedHandler
    
    var onSuccess: LoginSuccessHandler {
        get {
            return _onSuccess
        }
    }
    var onFailed: LoginFailedHandler {
        get {
            return _onFailed
        }
    }
    //构造器
    init( onSuccess :@escaping LoginSuccessHandler = {_,_ in }, onFailed :@escaping LoginFailedHandler = {_, _ in }) {
        _onSuccess = onSuccess
        _onFailed = onFailed
    }
    
}

//账户切换回调
public struct AccountSwitchCallback {
    
    private var _onSwitch: AccountSwitchHandler
    
    var onSwitch: AccountSwitchHandler {
        get {
            return _onSwitch
        }
    }
    
    init(onSwitch:@escaping AccountSwitchHandler = {}) {
        _onSwitch = onSwitch
    }
}



//支付回调
public struct PayCallback {
    private var _onSuccess : PaySuccessHandler
    private var _onFailed : PayFailedHandler
    
    var onSuccess: PaySuccessHandler {
        get {
            return _onSuccess
        }
    }
    var onFailed: PayFailedHandler {
        get {
            return _onFailed
        }
    }
    //构造器
    init( onSuccess :@escaping PaySuccessHandler = {_ in }, onFailed :@escaping PayFailedHandler = {_,_  in }) {
        _onSuccess = onSuccess
        _onFailed  = onFailed
    }
    
}

public struct ExitCallback{
    private var _onExit: ExitHandler
    
    var onExit:ExitHandler {
        get{
            return _onExit
        }
    }
    init(onExit:@escaping ExitHandler = {}){
        _onExit = onExit
    }
    
}

public class SnakeCallback {
    
    static let sharedInstance = SnakeCallback()
    private init() {}
    
    private var _pay:           PayCallback?
    private var _login:         LoginCallback?
    private var _switch: AccountSwitchCallback?
    private var _exit:              ExitCallback?
    
    //登录回调
    var login: LoginCallback? {
        get {
            return _login
        }
        set {
            _login = newValue
        }
    }
    
    //支付
    var pay: PayCallback? {
        get {
            return _pay
        }
        set {
            _pay = newValue
        }
    }
    
    //账户切换
    var accountSwitch: AccountSwitchCallback? {
        get {
            return _switch
        }
        set {
            _switch = newValue
        }
    }
    
    //退出
    var exit: ExitCallback?{
        get{
            return _exit
        }
        set{
            _exit = newValue
        }
    }
    

    
}
