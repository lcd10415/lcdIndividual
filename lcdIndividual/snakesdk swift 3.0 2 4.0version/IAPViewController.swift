//
//  IAPViewController.swift
//  snakesdk
//
//  Created by tgame on 16/8/1.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit

class IAPViewController: UIViewController {
    
    @IBOutlet weak var _lblGame: UILabel!
    @IBOutlet weak var _lblGoods: UILabel!
    @IBOutlet weak var _lblPrice: UILabel!
    @IBOutlet weak var _lblAccount: UILabel!
    @IBOutlet weak var _lblCurPoints: UILabel!
    
    //点卡
    @IBOutlet weak var _vSnake: UIView!
    @IBOutlet weak var _vAlipay: UIView!
    @IBOutlet weak var _vUnionPay: UIView!
    @IBOutlet weak var _vWechat: UIView!
    
    @IBOutlet weak var _vHeader: UIView!
    //非点卡支付
    @IBOutlet weak var _vGuestWechat: UIView!
    @IBOutlet weak var _vGuestAlipay: UIView!
    @IBOutlet weak var _btnRecharge: UIButton!
    @IBOutlet weak var _vGuestPayWay: UIView!
    @IBOutlet weak var _vPoints: UIView!
    @IBOutlet weak var _vPayArea: UIView!
    //提示
    @IBOutlet weak var _vWarnning: UIView!
    
    @IBOutlet weak var _vBackground: UIView!
    @IBOutlet weak var _vAlertBackground: UIView!
    @IBOutlet weak var _vSuccessAlert: UIView!
    
    
    @IBOutlet weak var _vWechatAlert: UIView!
    
    private let _highlightColor = [NSAttributedStringKey.foregroundColor: UIColor.orange]
    private let _normalColor = [NSAttributedStringKey.foregroundColor: UIColor.gray]
    
    //支付结果通知
    private  weak var _unionResultObserver: NSObjectProtocol?
    private  weak var _wechatResultObserver: NSObjectProtocol?
    
    private var _snakePayResult: String = ""
    
    var context: Context!
    var payWay:PayWay!
    
    
    let tagSnakePayConfirm = 1  //snake pay确认
    let tagSnakePayResult = 2   //snake pay结果
    
    private func _addGestureForViews( canSnakePay: Bool) {
        
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vAlipay, #selector(IAPViewController.handleAlipay) )
        f(_vUnionPay, #selector(IAPViewController.handleUnionpay) )
        f(_vWechat, #selector(IAPViewController.handleWeChat) )
        f(_vGuestAlipay,#selector(IAPViewController.handleAlipay))
        f(_vGuestWechat,#selector(IAPViewController.handleWeChat))
        //点卡支付
        if canSnakePay {
            f(_vSnake, #selector(IAPViewController.handleSnakePay) )
        }
        
    }
    
    private func _addBorderForViews() {
        let border = Border(size: 0.5, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        let f = { /*[unowned self]*/ (v: UIView) in
            v.borderBottom = border
            
        }
        
        f(_vHeader)
        
    }
    
    @IBAction func onWechatConfirmClicked(sender: UIButton) {
        _vBackground.isHidden = true
    }
    @IBAction func onReturnGameClicked(sender: UIButton) {
        self._handleSnakePayResult(result: self._snakePayResult)
        _vBackground.isHidden = true
        
    }
    @IBAction func onReturnClicked(sender: UIButton) {
        _vBackground.isHidden = true
    }
    
    @IBAction func onConfirmClicked(sender: UIButton) {
        handleSnakePayConfirmed()
        _vSuccessAlert.isHidden = false
        _vAlertBackground.isHidden = true
    }
    private func _setBalanceTips( balance: Int, price: Int) {
        
        let tips = NSMutableAttributedString(string: "availablePoints".localized, attributes:  _normalColor)
        let points = NSAttributedString(string: " \(balance)点 ", attributes:  _highlightColor)
        let rate = NSMutableAttributedString(string: "exchangeRate".localized, attributes:  _normalColor)
        let shortage = NSAttributedString(string: " \("insufficientBalance".localized)", attributes:  _highlightColor)
        
        
        tips.append(points)
        tips.append(rate)
        
        if balance < price {
            tips.append(shortage)
        }
        
        _lblCurPoints.attributedText = tips
        
        
    }
    
    private func _setUIElements() {
        
       
        _setViewCornerRadius()
        _addBorderForViews()
        
        let amount = (context.payment?.amount)!
        let balance = context.any as! Int
        
        _lblGoods.text = context.payment?.productName
        _lblGame.text = context.role?.game
        _lblPrice.text = "\((Double(amount) / 100).format(f: ".2"))元"
        _lblAccount.text = context.account
        
        _setBalanceTips(balance: balance, price: amount)
        
        _addGestureForViews(canSnakePay: balance >=  amount)
        
        if Utils.curUserType() == .Guest {
            _vWarnning.isHidden = true
            _vPoints.isHidden = true
            _vPayArea.isHidden = true
            _vGuestPayWay.isHidden = false
        } else {
            _vPoints.isHidden = false
            _vPayArea.isHidden = false
            _vGuestPayWay.isHidden = true
            _vSnake.isHidden = balance >= amount ? false : true
            _vWarnning.isHidden = balance >= amount ? true :false
        }
        
        
        
        
    }
    private func _setViewCornerRadius(){
        _vBackground.isHidden = true
        
        Meta.setBtnCornerRadius(_vAlertBackground)
        Meta.setBtnCornerRadius(_vSuccessAlert)
        Meta.setBtnCornerRadius(_vWechatAlert)
    }
    
    private func _payByWeChat(result:[String:String]){
        if WXApi.isWXAppInstalled() {
            let dict = makeWeChatPrePayInfoDict(partnerId: result["partnerid"]! as String,appID: result["appid"]! as String,prepayId:result["prepayid"]! as String,nonceStr: result["noncestr"]! as String, timeStamp: result["timestamp"]! as String, sign: result["sign"]! as String)
            Payment.sharedInstance.payByWeChat(params: dict)
        } else {
           Utils.localShowToast(message: "请安装微信客户端")
        }
        
        
    }
    
    private func _payByAlipay(result: [String:String]) {
        
        Payment.sharedInstance.payByAliPay(params: result["params"]!, sign: result["sign"]!, signType: result["sign_type"]!){ [unowned self] result in
            self._handlePayResult(result: result)
        }

        
    }
    
    //todo: move mode to config.plist ?
    private func _payByUnionPay(result: [String:String]) {
        Payment.sharedInstance.payByUnionPay(tn: result["tn"]!, mode: UnionpayMode.Dev, viewController: self)
        
    }
    
    private func _handlePayHelper(type: OrderType, payBy: PayBy) {
        
        self.payWay = .Pay
        
        Payment.sharedInstance.payBy = payBy
        
        Snake.sharedInstance.genIAPOrder(
            context: context,
            type:  type,
            payBy: payBy) { (result: [String:String]?, ok: Bool) -> Void  in
                
                if !ok {
                    return
                }
                
                switch Payment.sharedInstance.payBy {
                    
                case .AliPay:
                    self._payByAlipay(result: result!)
                    
                case .UnionPay:
                    self._payByUnionPay(result: result!)
                    
                case .WeChat:
                    self._payByWeChat(result: result!)
                    
                //对于点卡支付,创建订单与消费操作一步到位
                case .Snake:
                    self._snakePayResult = result!["result"]!
                    
                    
                default:
                    break
                }
                
        }  // end of Snake.sharedInstance. genIAPOrder(
        
        
    }
    
    private func _handlePayResult( result: PayResult) {
        
        var tips = ""
        
        switch result {
        case .Success:
            tips = "pay".localized + "\(context.payment!.productName)" + "success".localized
            SnakeCallback.sharedInstance.pay?.onSuccess(context.payment?.transparent)

        case .Cancel:
            tips = "payCancel".localized
            SnakeCallback.sharedInstance.pay?.onFailed(tips, context.payment?.transparent)
            
        case .Failed:
            tips = "payFailed".localized
            SnakeCallback.sharedInstance.pay?.onFailed(tips, context.payment?.transparent!)
            
        }
        
        if #available(iOS 8.0, *) {
            Utils.skipShowToast(message: tips)
        }
        

        view.window!.rootViewController!.dismiss(animated: true);
        
    }
    
    private func _addNotificationObserver() {
        
        _unionResultObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Notification.PayResult),
            object: nil,
            queue: OperationQueue.main) { [unowned self](notitifaction) -> Void in
                if self.payWay == .Recharge{
                    return
                }
                if self.payWay == .Pay{
                    let value = notitifaction.object as! String
                    self._handlePayResult(result: PayResult(rawValue: value)!)
                }
                
        }
        _wechatResultObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Notification.WechatPayed),
            object: nil,
            queue: OperationQueue.main) { [unowned self](notitifaction) -> Void in
                if self.payWay == .Recharge{
                    return
                }
                if self.payWay == .Pay{
                    let value = notitifaction.object as! String
                    self._handlePayResult(result: PayResult(rawValue: value)!)
                }
                
        }
        
    }
    
    private func _handleSnakePayResult( result: String ) {
    
        var res: PayResult
        if result == "success" {
            res = .Success
            
        } else {
            res = .Failed
        }
        
        _handlePayResult(result: res)
        
        
    }
    
    
    @IBAction func onRechargeClicked(sender: AnyObject) {
        self.payWay = .Recharge
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
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUIElements()
        _addNotificationObserver()
    }
    
    
    @objc func handleSnakePay() {
        _vBackground.isHidden = false
        self.view.bringSubview(toFront: _vBackground)
        _vBackground.bringSubview(toFront: _vAlertBackground)
    }
    
    @objc func handleAlipay() {
        _handlePayHelper(type: .ThirdPay, payBy: .AliPay)
        
    }
    @objc func handleUnionpay() {
        _handlePayHelper(type: .ThirdPay, payBy: .UnionPay)
        
    }
    @objc func handleWeChat() {
        _handlePayHelper(type: .ThirdPay, payBy: .WeChat)
    }
    

    func handleSnakePayConfirmed() {
        _handlePayHelper(type: .UseToken, payBy: .Snake)
        
    }
    


    
    deinit {
        if let observer = _unionResultObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer = _wechatResultObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    
}
