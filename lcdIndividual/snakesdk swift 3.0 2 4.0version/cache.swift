//
//  cache.swift
//  snakesdk
//
//  Created by tgame on 16/7/6.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//import KeychainAccess

//基于keychain实现的持久缓存
class Cache {
    static let sharedInstance = Cache()
    
    private let _keychain = KeychainSwift(keyPrefix: Constant.KeyChainService)
    
    //设备id
    private let _deviceIDKey = "device_id"
    
    //当前用户的账户名、token、与类型
    private let _curUserAccountKey = "current_user_account"
    private let _curUserTokenKey = "current_user_token"
    private let _curUserTypeKey = "current_user_type"
    private let _code = "code"
    
    private init() {}
    //设备uuid
    var deviceID: String {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        var id = ""
        //使用已有
        if let id =  _keychain.get(_deviceIDKey) {
            return id
        }

        //创建一个新的游客id
        id = Meta.deviceUUID()
            if !_keychain.set(id, forKey: _deviceIDKey, withAccess: .accessibleWhenUnlocked) {
                SnakeLogger.sharedInstance.error(dictionary: [
                    "component": "cache",
                    "action":    "deviceID",
                    "error":     "failed",
                    "key":       "\(_deviceIDKey)",
                    "id":        "\(id)"])
                return  ""
            }
        return id

        
    }
    
    //当前用户
    var currentUser: String? {
        set {
            if !_keychain.set(newValue!, forKey: _curUserAccountKey, withAccess: .accessibleWhenUnlocked) {
                    SnakeLogger.sharedInstance.error(dictionary: [
                        "component": "cache",
                        "action":    "currentUser",
                        "new":        "\(newValue!)"])
            }
        }
        get {
            return _keychain.get(_curUserAccountKey)
        }
    }
    
    //当前用户的token
    var currentToken: String! {
        set {
            if !_keychain.set(newValue!, forKey: _curUserTokenKey, withAccess: .accessibleWhenUnlocked) {
                    SnakeLogger.sharedInstance.error(dictionary: [
                        "component": "cache",
                        "action":    "currentToken",
                        "new":        "\(newValue!)"])
                    
            }
        }
        get {
            return _keychain.get(_curUserTokenKey)
        }
    }
    

    //当前用户类型
    var currentUserType: Int? {
        set {
            var val = ""
            
            if let v = newValue {
                val = String(v)
            }
            if !_keychain.set(val, forKey: _curUserTypeKey, withAccess: .accessibleWhenUnlocked) {
                    SnakeLogger.sharedInstance.error(dictionary: [
                        "component": "cache",
                        "action":    "currentUserType",
                        "new":        "\(newValue!)"])
                }
        }
        
        get {
            guard let type = _keychain.get(_curUserTypeKey) else {
                return nil
            }
            return Int(type)
        }
    }
    
    //微信登录的生成的code
    var code: String?{
        set {
            if !_keychain.set(newValue!, forKey: _code) {
                    SnakeLogger.sharedInstance.error(dictionary: [
                        "component": "cache",
                        "action":    "code",
                        "new":        "\(newValue)"])
            }
        }
        get {
            return _keychain.get(_code)
        }
        
    }

    
}
