//
//  AgreementViewController. swift
//  snakesdk
//
//  Created by mac on 16/7/26.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit
import WebKit

class AgreementViewController: UIViewController,UIWebViewDelegate{
    
    @IBOutlet weak var _lblTitle: UILabel!
    @IBOutlet weak var _vWebBg: UIView!
    
    private var _vWeb:UIWebView!
    private var _closer: Closer!
    
   
    var identifier :String?
    
    override func viewDidLoad() {
        
        _setupWebView()
        _loadContents()
    }
    
    //加载网页和设置标题
    private func _loadRequest(url:String, title:String){
        guard let dict = try? Dictionary<String, AnyObject>.loadPlistFromBundle(filename: Constant.ConfigPlist) else{
            return
        }
        
        let webURL: String = dict[url] as! String
        
        _vWeb.loadRequest(URLRequest(url: NSURL(string: webURL)! as URL) as URLRequest)

        
        _lblTitle.text = title.localized
    }
    
    private func _loadContents(){
        
        switch identifier! {
        case "termsOfService":
            _loadRequest(url: "termsOfService_url", title: "termsOfService")
            
        case "privacyPolicy":
            _loadRequest(url: "privacyPolicy_url", title: "privacyPolicy")
            
        case "helpCenter":
            _loadRequest(url: "helpCenter_url", title: "helpCenter")
            
        case "gameCenter":
            _loadRequest(url: "gameCenter_url", title: "gameCenter")
            
        default:
            break
        }
}
    override func viewDidLayoutSubviews() {
        _vWeb.frame = _vWebBg.bounds
    }

    private func _setupWebView(){
        _vWeb = UIWebView(frame: self.view.frame)
        _vWeb.delegate = self
        
        _vWeb.scalesPageToFit = true
        //禁止webView的下拉拖动出现空白背景
        _vWeb.scrollView.bounces = false
        self._vWebBg.addSubview(_vWeb)
    }
    
    //# MAARK UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        _closer = Utils.showLoading()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        _closer()
    }
}
