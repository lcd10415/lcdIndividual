//
//  AertMessage.swift
//  snakesdk
//
//  Created by mac on 16/7/18.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit




class AlertMessageView: UIView{
    private var _viewWidth: Double!
    private var _viewHeight: Double!
    
    private var _btnExit: UIButton!
    private var _btnCancel: UIButton!
    
    private var _strTitle: String! = ""
    private var _strMessage: String! = ""
    
    private var _lblTitle: UILabel!
    private var _lblMessage: UIButton!
    
    private var _vBg: UIView!
    
    
    
    init(title: String?) {
        
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: Meta.screenW,height: Meta.screenH))
        _setupAttributes(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupAttributes(title: String?) {
        clipsToBounds = true
        _strTitle = title
        _viewWidth = UIDeviceOrientationIsLandscape(.LandscapeLeft) && UIDeviceOrientationIsLandscape(.LandscapeRight) ? 384.0 : 216.0
        _viewHeight = UIDeviceOrientationIsLandscape(.LandscapeLeft) && UIDeviceOrientationIsLandscape(.LandscapeRight) ? 216.0 : 384.0
        _setUpElements()
        _addGestureRecognizer()
    }
    
    private func _addGestureRecognizer() {
        self.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(AlertMessageView.handleGesture(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    private func _setUpElements()
    {
        _lblTitle = UILabel(frame:CGRectZero)
        _lblTitle.text = _strTitle
        _lblTitle.textColor = UIColor.blackColor()
        _lblTitle.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        _lblTitle.font = UIFont.boldSystemFontOfSize(17)
        _lblTitle.textAlignment = NSTextAlignment.Center
        
        _lblMessage = UIButton(type: UIButtonType.Custom)
        _lblMessage.backgroundColor = UIColor.whiteColor()
        _lblMessage.setBackgroundImage(UIImage(named: "lkt0wer_snake_advertise.png"), forState: .Normal)
        
        _btnCancel = UIButton(type: UIButtonType.Custom)
        _btnCancel.backgroundColor = UIColor(white: 0.8,alpha: 1.0)
        _btnCancel.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        _btnCancel.titleLabel?.font = UIFont.boldSystemFontOfSize(15)
        _btnCancel.setTitle("cancel".localized, forState: UIControlState.Normal)
        
        _btnExit = UIButton(type: UIButtonType.Custom)
        _btnExit.backgroundColor = UIColor.orangeColor()
        _btnExit.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        _btnExit.titleLabel?.font = UIFont.boldSystemFontOfSize(18)
        _btnExit.setTitle("exit".localized, forState: UIControlState.Normal)
        
        _vBg = UIView(frame:  CGRect(x: 0,y: 0,width: _viewWidth,height: _viewHeight))
        _vBg.addSubview(_btnExit!)
        _vBg.addSubview(_lblTitle)
        _vBg.addSubview(_lblMessage!)
        _vBg.addSubview(_btnCancel!)
    }
    
    private func _removeViewFromSuperView() {
        _vBg.removeFromSuperview()
        self.removeFromSuperview()
        
    }
    
    @objc private func handleGesture(sender:UITapGestureRecognizer){
        _removeViewFromSuperView()
    }
    private func _layoutFrame(){
        
        
        _btnExit.addTarget(self, action: #selector(AlertMessageView.onPlayClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        _btnExit.frame = CGRect(x: _viewWidth/2, y: _viewHeight-40, width: _viewWidth/2, height: 40)
        
        _btnCancel.addTarget(self, action: #selector(AlertMessageView.onLoginClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        _btnCancel.frame = CGRect(x:0, y: _viewHeight-40, width: _viewWidth/2, height: 40)
        
        _lblTitle.frame = CGRect(x: 0, y: 0, width: _viewWidth, height: 45)
        
        _lblMessage.frame = CGRect(x: 0, y: 0, width: _viewWidth, height: _viewHeight - 85)
        _lblMessage.center = _vBg.center
        _lblMessage.addTarget(self, action: #selector(AlertMessageView.onGameCenterClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    private func _addBgViewTo(parent: UIView){
        let alertCornerRadius = 10.0
        //        let viewY:Double! = (Double(parent.frame.size.height) - _viewHeight)/2
        _vBg.bounds = CGRect(x: 0 ,y: 0, width: _viewWidth, height: _viewHeight)
        _vBg.center = parent.center
        _vBg.backgroundColor = UIColor.whiteColor()
        _vBg.layer.masksToBounds = true
        _vBg.layer.cornerRadius = CGFloat(alertCornerRadius)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        self.frame = parent.frame
    }
    
    func onGameCenterClick(button: UIButton){
        guard let dstVC = UIStoryboard(name:"SnakeSDK",bundle: nil).instantiateViewControllerWithIdentifier("AgreementViewController") as? AgreementViewController else {
            return
        }
        
        dstVC.identifier = "gameCenter"
        UIViewController.topMostViewController()!.presentViewController(dstVC, animated: true, completion: nil)
        
    }
    
    
    func onPlayClicked(button: UIButton) {
        Utils.skipShowToast("channelExit".localized)
        SnakeCallback.sharedInstance.exit?.onExit()
        _removeViewFromSuperView()
    }
    
    func onLoginClicked(button: UIButton) {
        _removeViewFromSuperView()
    }
    
    
    //显示alert view,为其添加background & 子控件的position
    func showBy(parent: UIView) {
        _layoutFrame()
        self._addBgViewTo(parent)
        parent.addSubview(self)
        parent.addSubview(_vBg)
        parent.bringSubviewToFront(_vBg)
    }
}
