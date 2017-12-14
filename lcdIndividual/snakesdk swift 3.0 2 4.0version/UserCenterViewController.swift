//
//  UserCenterViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/22.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit


class UserCenterViewController: UIViewController {
    
    var context: Context!    
    weak var nameObserver:NSObjectProtocol?
    
    //账户类型
    @IBOutlet weak var _imgAccountType: UIImageView!
    
    //账号充值
    @IBOutlet weak var _vCharge: UIView!
    
    //账号管理
    @IBOutlet weak var _vAccount: UIView!
    
    //帮助中心
    @IBOutlet weak var _vHelper: UIView!
    
    //账号提示
    @IBOutlet weak var _lblTips: UILabel!
    
    @IBOutlet weak var _lblTitle: UILabel!
    
    //绑定或切换账号
    @IBOutlet weak var _btnBindingOrSwitch: UIButton!
    
    //游客中心
    @IBOutlet weak var _btnHelper: UIButton!
    
    //退出当前账号
    @IBOutlet weak var _btnGuestExit: UIButton!
    
    //游客状态提示
    @IBOutlet weak var _lblGuestTips: UILabel!
    
    //游客账号提示界面
    @IBOutlet weak var _vGuest: UIView!
    
    //手机、贪玩蛇账号的功能选择界面
    @IBOutlet weak var _vDashboard: UIView!
    
    //帮助中心
    @IBAction func onHelperClicked(_ sender: UIButton) {
        handleHelper()
    }
    
    //退出游客账号
    //todo: bug
    @IBAction func onGuestExitClicked(_ sender: UIButton) {
        _presentAccountSwitchVC()
        
    }
    
    //充值管理
    @objc func handleCharge() {
        
        Snake.sharedInstance.accountBalance() { [unowned self ] (balance: Int, ok: Bool) -> Void in
            
            if !ok {
                //todo: lewgun
            }
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "RechargePlatformChooseViewController") as? RechargePlatformChooseViewController else {
                return
            }
        
            vc.context = self.context
            
            //余额
            vc.context.any = balance
            
            UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    //账号管理
    @objc func handleAccount() {
        //手机账号要先verify
        if Utils.curUserType() != .Phone {
            if Utils.curUserType()! == .ThirdParty {
                return
            }
            _presentAccountManagmentVC()
            return
        
        }
       
        
        context.phone = context.account
        Snake.sharedInstance.checkAccountInfo(
            context: context,
            type:     RegisterOrVerifyBy.Phone) { [unowned self] (status : PhoneStatus, ok: Bool)  in
                if !ok {
                    return
                }
                
                //todo: lewgun
                self.context.any = status
                self._presentAccountManagmentVC()
        }
        
    }
    
    //帮助中心
    @objc func handleHelper() {
            guard let dstVC = UIStoryboard(name:"SnakeSDK",bundle: nil).instantiateViewController(withIdentifier: "AgreementViewController") as? AgreementViewController else{
                return
            }
            
            dstVC.identifier = "helpCenter"
            self.present(dstVC, animated: true, completion: nil)
    }
    

    
    //todo: need remove ?
    private func _addGestureForViews() {
        
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vCharge, #selector(UserCenterViewController.handleCharge) )
        f(_vAccount, #selector(UserCenterViewController.handleAccount) )
        f(_vHelper, #selector(UserCenterViewController.handleHelper) )
        
    }
    
    private func _addBorderForViews() {
        
        let border = Border(size: 1, color: UIColor.gray, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderTop = border
            v.borderBottom = border
            v.borderLeft = border
            
            }
        
        f(_vCharge)
        f(_vAccount)
        f(_vHelper)
        
        //补上最后一根竖线
        _vHelper.borderRight = border


    }
    
    private func _setUIElements() {
        Meta.setBtnCornerRadius(_btnGuestExit)
        
        _vGuest.isHidden = true
        _vDashboard.isHidden = true
        
        var tips = ""
        var title = ""
        var img: UIImage?
        
        var strBindingOrSwitch = "switchAccount".localized
        
        let by = Utils.curUserType()!
        switch by {
        case LoginBy.Snake:
            title = "account".localized
            tips = "\("account".localized) \(Cache.sharedInstance.currentUser!)"
            img = UIImage(named: "lkt0wer_usercenter_channel.png")
  
        case LoginBy.Phone:
            title = "phone".localized
            tips = "\("phone".localized) \(Cache.sharedInstance.currentUser!)"
            img = UIImage(named: "lkt0wer_usercenter_phone.png")

            
        case LoginBy.Guest:
                title = "guest".localized
                tips = "\("guest".localized) \(Cache.sharedInstance.currentUser!)"
                img = UIImage(named: "lkt0wer_usercenter_guest.png")
                strBindingOrSwitch = "bindSnackAccount".localized
                _btnGuestExit.setTitle("exitGuestAccount".localized, for: UIControlState.normal)
        case LoginBy.ThirdParty:
            title = "thirdParty".localized
            tips = "\("thirdParty".localized)\(Cache.sharedInstance.currentUser!)"
            img = UIImage(named: "")
            strBindingOrSwitch = "bindSnackAccount".localized
            _btnGuestExit.setTitle("exitThirdPartyAccount".localized, for: UIControlState.normal)
        default:
            break
        }
        _lblTips.text = tips
        _imgAccountType.image = img
        _btnBindingOrSwitch.setTitle(strBindingOrSwitch, for: .normal)
        
        Utils.setAttributedText(lbl: _lblTips, texts: [title, Cache.sharedInstance.currentUser!])

        //手机或贪玩蛇
        if by != LoginBy.Guest && by != LoginBy.ThirdParty {
            _addGestureForViews()
            _addBorderForViews()
            _vDashboard.isHidden = false
            return
        }
        _vGuest.isHidden = false

    }
    
    //账户切换
    private func _presentAccountSwitchVC () {
        Utils.clearCurUser()
        self.dismiss(animated: true) {
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
                return
            }
            
            vc.context = self.context
            if #available(iOS 8.0, *) {
                vc.modalPresentationStyle = .overCurrentContext
            } else {
                vc.modalPresentationStyle = .currentContext
            }
            UIViewController.topMostViewController()!.definesPresentationContext = true
            
            UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
            
        }
        
           

    }
    
    //账户绑定
    private func _presentAccountBindingVC() {
        
        self.dismiss(animated: true) {
            
            guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "SnakeLoginOrBindingViewController") as? SnakeLoginOrBindingViewController else {
                return
            }
            
            vc.context = self.context

            //显示为绑定账户界面
            let tagBinding = 1
            
            //显示为绑定UI
            vc.context.any = tagBinding
            if #available(iOS 8.0, *) {
                vc.modalPresentationStyle = .overCurrentContext
            } else {
                vc.modalPresentationStyle = .currentContext
            }
            vc.definesPresentationContext = true
            
            UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    //账户管理
    private func _presentAccountManagmentVC() {
        
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "AccountManagementViewController") as? AccountManagementViewController else {
            return
        }
        
        vc.context = self.context
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
    
    }

    
    //绑定或切换账户
    @IBAction func onBindingOrSwitchAccountClicked(sender: AnyObject) {
        
        if LoginBy(rawValue: Cache.sharedInstance.currentUserType!) == LoginBy.Guest || LoginBy(rawValue: Cache.sharedInstance.currentUserType!) == LoginBy.ThirdParty{
             _presentAccountBindingVC()
            return
        
        }
        _presentAccountSwitchVC()
    }
    
    //注册通知
    private func _addObserverForName(){
        if Utils.curUserType() == .Phone {

            nameObserver = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: Notification.PhoneNumberChanged), object: nil, queue: OperationQueue.main) { [unowned self](info) in
                self._lblTips.text = "phone".localized + ((info.userInfo!["text"])! as! String)
                
                Utils.setAttributedText(lbl: self._lblTips, texts: ["phone".localized, (info.userInfo!["text"])! as! String])
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.context?.account = Cache.sharedInstance.currentUser!

        _setUIElements()
        
        _addObserverForName()
    }
    
    deinit {
        if let nameObserver = nameObserver {
             NotificationCenter.default.removeObserver(nameObserver)
        }
    }
}
