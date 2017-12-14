//
//  logger.swift
//  snakesdk
//
//  Created by tgame on 16/8/9.
//  Copyright © 2016年 snakepop. All rights reserved.

//http://blog.devzeng.com/blog/ios-plcrashreporter.html

import Foundation


//snake日志
public class SnakeLogger{
    
    static let sharedInstance = SnakeLogger()
    private init() {
        Slim.addLogDestination(SlimLogglyDestination())
    }
    

    //MARK:errors
    private func _error( array: [Any], filename: String = #file, line: Int = #line) {
        Slim.error(array, filename: filename, line: line)
    }
    
    func error(dictionary : [String:Any], filename: String = #file, line: Int = #line ) {
        Slim.error(dictionary, filename: filename, line: line)
    }
    
    //MARK:events
    private func _event( array: [Any], filename: String = #file, line: Int = #line) {
        Slim.trace(array, filename: filename, line: line)
    }
    
    func event(dictionary : [String:Any], filename: String = #file, line: Int = #line) {
        Slim.trace(dictionary, filename: filename, line: line)
    }
    
}
