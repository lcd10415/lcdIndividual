//
//  config.swift
//  snakesdk
//
//  Created by tgame on 16/7/6.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import Foundation


public class Config {
    
    static let sharedInstance = Config()
    private init() {
        if let dict = try? Dictionary<String, AnyObject>.loadPlistFromBundle(filename: Constant.ConfigPlist) {
            _appID = dict["app_id"] as! String
            _channelID = dict["channel_id"] as! String

        }
    }

    private var _appID:String = ""
    var appID: String {
        get {
            return _appID
        }
    }
    
    private var _channelID:String = ""
    var channelID: String {
        get {
            return self._channelID
        }
    }
    
    public var description: String {
        return "appID: \(appID) channelID: \(channelID)"
    }
    
}
