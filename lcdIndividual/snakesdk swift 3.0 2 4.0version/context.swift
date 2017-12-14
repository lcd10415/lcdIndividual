//
//  context.swift
//  snakesdk
//
//  Created by tgame on 16/8/10.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//ViewController的上下文,如果需要从前一个VC向当前VC传递数据，则当前VC必须有一个此类型的属性
struct Context {
    
    //账户角色信息
    private var _role: RoleInfo!
    var role: RoleInfo? {
        set {
            _role = newValue
        }
        get {
            return _role
        }
    }
    
    //支付信息
    private var _payment: PaymentInfo!
    var payment: PaymentInfo? {
        set {
            _payment = newValue
        }
        get {
            return _payment
        }
    }
    
    //手机号
    private var _phone: String?
    var phone: String? {//
        set {
            _phone = newValue
        }
        get {
            return _phone
        }
    }
    
    //账户
    private var _account: String?
    var account: String? {//
        set {
            _account = newValue
        }
        get {
            return _account
        }
    }
    
    //密码
    private var _password: String?
    var password: String? {
        set {
            _password = newValue
        }
        get {
            return _password
        }
    }
    

    
    //调用api时传入的透传参数
    private var _transparent: AnyObject?
    var transparent: AnyObject? {
        set {
            _transparent = newValue
        }
        get {
            return _transparent
        }
    }
    
    
    //额外信息(任意值,在使用时必须关注其环境)
    private var _any: Any?
    var any: Any? {//
        set {
            _any = newValue
        }
        get {
            return _any
        }
    }
    
}

