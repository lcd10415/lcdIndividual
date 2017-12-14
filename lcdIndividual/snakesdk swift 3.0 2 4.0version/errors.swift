//
//  errors.swift
//  snakesdk
//
//  Created by tgame on 16/6/30.
//  Copyright © 2016年 snakepop. All rights reserved.
//

// 错误处理
struct errors  {
    
    static let unknownError = "服务器繁忙"
    static let errMap = [
        1000: unknownError,
        1006: "用户名已存在",
        1007: "认证失败",
        1012: "密码错误",
        1013: "未知用户名",
        1014: "未知手机号",
        1017: "手机号错误",
        1018: "手机号已注册",
        1021: "短信验证码错误",
        1027: "密码未设置",
        1030: "图形验证码错误",
        1032: "token已经过期",
        1037: "用户名不合法",
        1041: "该账号已在游戏中注册",
        1056: "获取短信验证码超频",
        1062: "该手机号已绑定"
    ]
    static func withCode( code: Int) -> String? {
        guard let err = errMap[code] else {
            print("错误码:\(code)")
            return unknownError
        }
        
        return err
    }
    
    //提取错误对应的string
    static func toString(err: Error) -> String {
        return "\(err)"
    }
}

//存储错误
public enum StoreError: Error {
    case Add(error: String)
    case Update( error: String)
    case Query(error: String)
    case Delete(error: String)
    case QueryAll
}

public enum SnakeError: Error {
    case NotFound
    case Login
}

