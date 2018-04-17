//
//  WKWeb.swift
//  SwiftLearning
//
//  Created by 178 on 2018/4/17.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
import WebKit

class WKWeb: UIViewController,WKScriptMessageHandler {
    //当JavaScript代码向WebKit中注册的交互方法发送消息后，系统会调用这个协议方法，传入一个WKScriptMessage类型的message参数，其中封装了传递消息内容，WKScriptMessage有body(消息体),webView(此消息网页视图来源),name(传递消息的方法名)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    //WKWebView能监听网页的前进和后退操作
    //public var backForwardList: WKBackForwardList{ get{} }
    /*
     public var currentItem: WKBackForwardListItem
     */
    
    
}
