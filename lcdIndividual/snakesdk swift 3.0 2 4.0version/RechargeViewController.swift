
//
//  RechargeViewController.swift
//  snakesdk
//
//  Created by tgame on 16/8/1.
//  Copyright © 2016年 snakepop. All rights reserved.
//

//http://www.qinyejun.com/ios/ios-alipay-swift/
//https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.nIt2KG&treeId=59&articleId=103563&docType=1
//http://www.jianshu.com/p/5848b6604033

import UIKit

class PointChooseViewCell : UICollectionViewCell,WXApiDelegate{
    
    @IBOutlet weak var _lblPoint: UILabel!
    @IBOutlet weak var _imgSelected: UIImageView!
    
    private let _normalBorder =  Border(size: 1, color: UIColor.gray, offset: UIEdgeInsets.zero)
    private let _selectedBorder = Border(size: 1, color: UIColor.orange, offset: UIEdgeInsets.zero)
    
    
    private func _setSelectHelper( selected: Bool) {
        let f = { [unowned self] (v: UIView, border: Border ) in
            v.borderTop = border
            v.borderLeft = border
            v.borderRight = border
            v.borderBottom = border
            
        }
        
        f(self, selected ? _selectedBorder : _normalBorder)
        
        _imgSelected.isHidden = !selected
        
    }
    
    
    func setup( name: String, tag: Int) {
        
        _lblPoint.text = name
        
        //默认为未选中
        _setSelectHelper(selected: false)
        
        self.tag = tag
        
    }
    
    func setSelected() {
        _setSelectHelper(selected: true)
        
    }
    func setDisselected() {
        _setSelectHelper(selected: false)
    }
    
    
}


class RechargeViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var _lblAmount: UILabel!
    
    @IBOutlet weak var _btnRecharge: UIButton!
    @IBOutlet weak var _vHeader: UIView!
    
    @IBOutlet weak var _vPoints: UICollectionView!
    
    private let _normalBorder =  Border(size: 0.5, color: Meta.borderColor, offset: UIEdgeInsets.zero)
    
    private let _highlightColor = [NSAttributedStringKey.foregroundColor: UIColor.orange]
    private let _normalColor = [NSAttributedStringKey.foregroundColor: UIColor.gray]
    
    private let _PointChooseViewCellID = "PointChooseViewCellID"
    
    private var _productions: [Production]!
    
    
    //支付结果通知
    private  weak var _unionResultObserver: NSObjectProtocol?
    private  weak var _wechatResultObserver: NSObjectProtocol?
    
    //当前选中的商品索引
    private var _selectedIndex = 0
    
    
    var context: Context!
    weak var rechargeDelegate: RechargeDelegate?
    
    private func _setUIElements() {
        
        Meta.setBtnCornerRadius(_btnRecharge)
        //header的下边框
        _vHeader.borderBottom = _normalBorder
        
    }
    
    //mark
    private func _setTipsAttributedText( money: Int) {
        
        let s = String(format: "%.2f", Double(money) / 100.0 )
        
        let tips = NSMutableAttributedString(string: "rechargeAmount".localized, attributes:  _normalColor)
        let price = NSAttributedString(string: " \(s) ", attributes:  _highlightColor)
        let unit = NSMutableAttributedString(string: "元", attributes:  _normalColor)
        
        tips.append(price)
        tips.append(unit)
        
        _lblAmount.attributedText = tips
        
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
    
    
    //Mark --WeChat
    private func _payByWeChat(result: [String:AnyObject]) {
        let dict = makeWeChatPrePayInfoDict(partnerId: result["partnerid"] as! String,appID: result["appid"] as! String, prepayId: result["prepayid"] as! String,nonceStr: result["noncestr"] as! String, timeStamp: result["timestamp"] as! String, sign: result["sign"] as! String)
        Payment.sharedInstance.payByWeChat(params: dict)
    }
    
    
    private func _handlePayResult( result: PayResult) {
        
        switch result {
        case .Success:
            Snake.sharedInstance.accountBalance(completion: { (balance, ok) in
                if !ok {
                    return
                }
                self.rechargeDelegate?.recharged(balance: balance)
                self.presentingViewController?.dismiss(animated: true)
            })
            
        //todo move to somelse?
        case .Cancel:
            Utils.localShowToast(message: "payCancel".localized)
            
        default:
            Utils.localShowToast(message: "payFailed".localized)
            
        }
        
    }
    
    private func _addNotificationObserver() {
        
        _unionResultObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Notification.PayResult),
            object: nil,
            queue: OperationQueue.main) { [unowned self](notitifaction) -> Void in
                let value = notitifaction.object as! String
                self._handlePayResult(result: PayResult(rawValue: value)!)
                
        }
        _wechatResultObserver = NotificationCenter.default.addObserver(
            forName: NSNotification.Name(rawValue: Notification.WechatPayed),
            object: nil,
            queue: OperationQueue.main) { [unowned self](notitifaction) -> Void in
                let value = notitifaction.object as! String
                self._handlePayResult(result: PayResult(rawValue: value)!)
                
        }
        
    }
    
    
    //mark
    @IBAction func onRechargeClicked(sender: AnyObject) {
        
        let p = _productions[_selectedIndex]
        
        Snake.sharedInstance.genRechargeOrder(context: context, type: .BuyToken, payBy: Payment.sharedInstance.payBy, productID: p.id) { (result: [String:String]?, ok: Bool) -> Void  in
            if !ok {
                return }
            
            switch Payment.sharedInstance.payBy {
                
            case .AliPay:
                self._payByAlipay(result: result!)
                
            case .UnionPay:
                self._payByUnionPay(result: result!)
            case .WeChat:
                self._payByWeChat(result: result! as [String : AnyObject])
                
            default:
                break
            }
            
        }  // end of Snake.sharedInstance.genSignedOrder(
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _productions = context.any as! [Production]
        
        _setUIElements()
        _addNotificationObserver()
        

    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return _productions.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath) as! PointChooseViewCell
        cell.setSelected()
        
        _selectedIndex = cell.tag
        
        let price = _productions[_selectedIndex].realPrice
        _setTipsAttributedText(money: price)
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath as IndexPath) as! PointChooseViewCell
        cell.setDisselected()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _PointChooseViewCellID, for: indexPath as IndexPath) as! PointChooseViewCell
        
        cell.setup(name: _productions[indexPath.row].name, tag: indexPath.row)
        
        
        //设置默认选择的点卡
        if indexPath.row == 0 && indexPath.section == 0{
            //此处修改了.none --> .top
            collectionView.selectItem(at: indexPath as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.top)
            cell.setSelected()
            
            _selectedIndex = 0
            let price = _productions[_selectedIndex].realPrice
            _setTipsAttributedText(money: price)
            
        }
        
        
        return cell
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


