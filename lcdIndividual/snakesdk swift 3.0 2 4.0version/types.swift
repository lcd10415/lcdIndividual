//
//  types.swift
//  snakesdk
//
//  Created by tgame on 16/6/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit


class Lock {
    private let _placeholder = true
}

public struct Placeholder{}


//用户信息
class User: CustomStringConvertible {
    let id:      Int64
    
    var type:    Int
    var key:     String
    var loginAt: Int64
    var account: String
    
    var description: String {
        return "id: \(id) type: \(type) account: \(account) key: \(key) loginAt: \(loginAt)"
    }
    
    init(id: Int64, type: Int, account: String, key: String, loginAt: Int64 ) {
        self.id = id
        self.type = type
        self.account = account
        self.key = key
        self.loginAt = loginAt
    }
    
}

//产品信息
class Production: CustomStringConvertible {
    let id:        String
    var name:      String
    var price:     Int
    var realPrice: Int
    
    var description: String {
        return "id: \(id) name: \(name) price: \(price) real price: \(realPrice)"
    }
    
    init(id: String, name: String, price: Int, realPrice: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.realPrice = realPrice
    }
    
}

//当前登录角色的信息
public class RoleInfo {
    private var _game:       String
    private var _id:         String
    private var _name:       String
    private var _serverID:   String
    private var _serverName: String
    private var _gameUserBalance: String
    private var _vipLevel: String
    private var _gameUserLevel: String
    private var _partyName: String
    
    //游戏史
    var game: String {
        get {
            return _game
        }
    }
    
    //角色id
    var ID: String {
        get {
            return _id
        }
    }
    
    //角色name
    var Name: String {
        get {
            return _name
        }
    }
    
    //服务器id
    var serverID: String {
        get {
            return _serverID
        }
    }
    
    //服务器名
    var serverName: String {
        get {
            return _serverName
        }
    }
    //玩家虚拟货币余额
    var gameUserBalancee: String {
        get {
            return _gameUserBalance
        }
    }
    //玩家vip等级
    var vipLevel: String {
        get {
            return _vipLevel
        }
    }
    // 玩家等级
    var gameUserLevel: String {
        get {
            return _gameUserLevel
        }
    }
    // 公会名称
    var partyName: String {
        get {
            return _partyName
        }
    }
    
    
    init(game: String, roleID: String, roleName: String, serverID: String, serverName: String,gameUserBalance: String, vipLevel: String, gameUserLevel: String, partyName: String) {
        _game = game
        _id = roleID
        _name = roleName
        _serverID = serverID
        _serverName = serverName
        _gameUserBalance = gameUserBalance
        _vipLevel = vipLevel
        _gameUserLevel = gameUserLevel
        _partyName = partyName
    }
    
    public var description: String {
        return "game: \(_game) roleID: \(_id) roleName: \(_name) serverID: \(_serverID) serverName: \(_serverName) gameUserBalance: \(_gameUserBalance) vipLevel: \(_vipLevel) gameUserLevel: \(_gameUserLevel) partyName: \(_partyName)"
    }
    
}


//支付信息
public class PaymentInfo {
    
    private var _count:  Int
    private var _amount: Int
    
    private var _id:   String
    private var _name: String
    private var _desc: String
    private var _notifyURL: String
    
    private var _transparent: AnyObject?
    
    //数量
    var count: Int {
        get {
            return _count
        }
    }
    
    //总金额
    var amount: Int {
        get {
            return _amount
        }
    }
    
    //产品id
    var productID: String {
        get {
            return _id
        }
    }
    
    //产品名
    var productName: String {
        get {
            return _name
        }
    }
    
    //产品描述
    var productDesc: String {
        get {
            return _desc
        }
    }
    
    //通知地址
    var notifyURL: String {
        get {
            return _notifyURL
        }
    }
    
    //透传参数
    var transparent: AnyObject? {
        get {
            return _transparent
        }
    }
    
    init(
        count:  Int,
        amount: Int,
        productID:   String,
        productName: String,
        productDesc: String,
        notifyURL:   String,
        transparent: AnyObject?
        ) {
        _count = count
        _amount = amount
        _id = productID
        _name = productName
        _desc = productDesc
        _notifyURL = notifyURL
        _transparent = transparent
        
    }
    
    public var description: String {
        return "count: \(_count) amount: \(_amount) productID: \(_id) productName: \(_name) productDesc: \(_desc) notifyURL: \(_notifyURL) transparent: \(_transparent)"
    }
    
}


public typealias Closer = ()->Void
public typealias Canceler = ()->Void

//登录completion
public typealias LoginCompletion = (Result<SnakeUserInfo>) ->Void


//登录
enum LoginBy: Int {
    case Invalid = 0
    case Guest = 1  //游客
    case Snake = 2  //贪玩蛇
    case Phone = 3  //手机
    case ThirdParty = 4 //第三方
    case SnakeAuto =  17 //(1<<4) + 1  //贪玩蛇自动
    case PhoneAuto = 18 //(1<<4) + 2   //手机自动
}
enum ThirdPartyLoginBy:Int {
    case Manual = 1  //手动
    case Auto = 2    //自动
}

//注册与验证流程
//注册并登录也是此流程
enum RegisterOrVerifyBy: Int {
    case Phone = 1   //手机注册、验证
    case Snake = 2 //贪玩蛇注册、验证
    
}

//修改用户信息
enum ModifyInfo: Int {
    case Phone = 1 //更换手机
    case PasswordModify = 2 //修改密码
    case PasswordFind = 3 //找回密码
}

//获取验证码的方式
public enum VerifyCodeBy: Int {
    case Phone = 1 //通过手机获取验证码
    case Name = 2 //通过用户名获取验证码
}

//手机账号状态
public enum PhoneStatus: Int {
    case illegal = 0 //无效
    case notRegistered = 1 //手机号没有注册过
    case firstLogin = 2 //平台注册过的手机号第一次登录本游戏
    case noPassword = 3 //手机账号没有设置密码
    case havePassword = 4 //手机账号已设置过密码
}

public enum PayBy: String {
    case AliPay = "alipay"
    case UnionPay = "unionpay"
    case WeChat = "wechat"
    case TenPay = "tenpay"
    case Snake = "snake"
}

//订单类型
public enum OrderType: Int {
    case BuyToken = 1 //购买代币
    case UseToken = 2 //消费代币
    case ThirdPay = 3 //三方支付平台消费
}


//https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.Cmz7Az&treeId=59&articleId=103671&docType=1
public enum AliPayResult: String {
    case Failed = "4000"   //订单支付失败
    case Cancel = "6001"   //用户取消
    case Unknown = "6004" //结果未知
    case Paying = "8000"  //支付中
    case Success = "9000"  //支付成功
    case Disconnected = "6002" //网络连接出错
    
}

//银联支付结果
public enum UnionPayResult: String {
    case Failed = "fail"       //订单支付失败
    case Cancel = "cancel"     //用户取消
    case Success = "success"   //支付成功
    
}
//购买选择方式
public enum PayWay: String{
    case Recharge = "recharge"   //充值
    case Pay = "pay"             //支付
}


//所有的支付结果最终都会转化为此类型
typealias PayResult = UnionPayResult

//unionpay 支付模式
public enum UnionpayMode: String {
    case Prod = "00" //产品模式
    case Dev = "01" //开发模式
    
}

// 选择当前登录用户
public protocol AccountChooseDelegate: class {
    func accountChoosed( id : Int64 ) ->Void
    
}

public protocol RechargeDelegate: class {
    func recharged( balance : Int ) ->Void
    
}

public class SnakeUserInfo {
    private let _appID: String
    var appID: String {
        get {
            return _appID
        }
    }
    
    private let _token:String
    var token: String {
        get {
            return self._token
        }
    }
    
    private let _channelID:String
    var channelID: String {
        get {
            return self._channelID
        }
    }
    
    init(appID: String, channelID: String, token: String ) {
        _appID = appID
        _token = token
        _channelID = channelID
    }
    
    public var description: String {
        return "appID: \(appID) token: \(token) channelID: \(channelID)"
    }
}




