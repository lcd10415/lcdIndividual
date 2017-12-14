//
//  configure.swift
//  snakesdk
//
//  Created by tgame on 16/6/27.
//  Copyright © 2016年 snakepop. All rights reserved.
//
import UIKit


//常量
struct Constant  {
    
    //keychain 名
    static let KeyChainService = "com.snakepop.keychain"
    
    //配置文件名
    static let ConfigPlist = "config"
    
    //电话号码长度
    static let PhoneNumberLen = 11
    
    //手机验证码长度
    static let VerifyCodeLen = 6
    
    //图形验证码长度
    static let CaptchaLen = 4
    
    //账户名长度约束
    static let MinAccountLen = 6
    static let MaxAccountLen = 32
    
    //密码长度约束
    static let MinPassLen = 8
    static let MaxPassLen = 32
    
    //支付使用的application scheme
    static let AppScheme = "snakesdk"
    
   
    
    //编辑框的高度
    static let TxtHeight = 30.0
    
    //设置button的圆角
    static let BtnCornerRadius: CGFloat = 5.0
    
}

