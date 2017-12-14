//
//  LoginViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/4.
//  Copyright © 2016年 snakepop. All rights reserved.
//



import UIKit

class AccountChooseViewCell : UITableViewCell {
    
    @IBOutlet weak var _imgIcon: UIImageView!
    @IBOutlet weak var _lblAccount: UILabel!
    @IBOutlet weak var _btnDelete: UIButton!
    
    private var _hadBorder : Bool = false
    func configure(user: User?) {
        guard let u = user else {
            return
        }
        
        var iconName: String = ""
        
        switch LoginBy(rawValue: u.type)! {
        case .Guest:
            iconName = "lkt0wer_snake_account_guest.png"
            
        case .Phone:
            iconName = "lkt0wer_snake_phone_account_manage_-1.png"
            
        case .Snake:
            iconName = "lkt0wer_snake_account_channel.png"
        default:
            break
            
        }
        
        _imgIcon.image = UIImage(named: iconName)
        _lblAccount.text = u.account
        
        _btnDelete.tag = Int(u.id)
        tag = Int(u.id)
        
        _addBorderForViews()
        
    }
    
    private func _addBorderForViews() {
        
        if _hadBorder {
            return
        }
        
        _hadBorder = true
        let border = Border(size: 1, color: UIColor.gray, offset: UIEdgeInsets.zero)
        //contentView.borderTop = border
        contentView.borderBottom = border
        // contentView.borderLeft = border
        // contentView.borderRight = border
        
    }
    
    func addDropShadow (){
        
        //        layer.shadowColor = UIColor.blackColor().CGColor
        //        layer.shadowOpacity = 1
        //        layer.shadowOffset = CGSizeMake(10, 10)
        //        layer.shadowRadius = 10
        //        layer.shadowPath = UIBezierPath(rect: bounds).CGPath
        //        layer.shouldRasterize = true
        
    }
    
    func removeDropShadow(){
        //        layer.shadowOpacity = 0;
    }
    
}


class LoginViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,AccountChooseDelegate ,UIAlertViewDelegate,UIViewControllerTransitioningDelegate {
    
    //当前用户名
    @IBOutlet weak var _lblCurUser: UILabel!
    @IBOutlet weak var _lblTitle: UILabel!
    
    //当前用户类型icon
    @IBOutlet weak var _imgCurUser: UIImageView!
    
    //当前用户view
    @IBOutlet weak var _vCurUser: UIView!

    //使用当前用户登录
    @IBOutlet weak var _vLoginByCurUser: UIView!
    
    //使用没有游客登录的方式"手机、贪玩蛇、第三方"
    @IBOutlet weak var _vLoginNotGuestType: UIView!
    //使用选择:"快速、手机、贪玩蛇、第三方等方式登录"
    @IBOutlet weak var _vLoginByType: UIView!
    
    @IBOutlet weak var _btnLogin: UIButton!

    @IBOutlet weak var _btnSwitchAccount: UIButton!
    
    //快速、手机、贪玩蛇登录
    @IBOutlet weak var _vSnakeLogin: UIView!
    @IBOutlet weak var _vPhoneLogin: UIView!
    @IBOutlet weak var _vGuestLogin: UIView!
    @IBOutlet weak var _vThirdLogin: UIView!
    
    @IBOutlet weak var _vPhoneNotGuestLogin: UIView!
    @IBOutlet weak var _vSnakeNotGuestLogin: UIView!
    @IBOutlet weak var _vThirdNotGuestLogin: UIView!
    //用户选择列表
    @IBOutlet weak var _vCachedAccount: UITableView!
    
    //工作区
    @IBOutlet weak var _vWorkArea: UIView!
    
    @IBOutlet weak var _vBackground: UIView!

    var context: Context!

    
    private var _users: [User]?
    private var _count = 0
    
    private let _IDAccountChooseViewCell = "AccountChooseViewCellID"
    private let _rowHeight = 30
    
    private func _userAtIndex( idx: Int) -> User? {
        if idx >= _count {
            return nil
        }
        return _users?[idx]
        
    }
    
    private func _deleteUser(id: Int64) {
        for i in 0 ..< _users!.count {
            if _users?[i].id == id {
                _users?.remove(at: i)
                _count -= 1
                break
            }
        }
        
        Store.sharedInstance.deleteUser(id: Int(id))
    }

    private func _addGestureForViews() {
        
        let f =  { [unowned self] (v : UIView, sel : Selector) in
            let tap = UITapGestureRecognizer(target: self, action: sel)
            tap.numberOfTapsRequired = 1
            v.addGestureRecognizer(tap)
        }
        
        f(_vCurUser, #selector(LoginViewController.handleMoreUser) )
        f(_vGuestLogin, #selector(LoginViewController.handleGuestLogin) )
        f(_vPhoneLogin, #selector(LoginViewController.handlePhoneLogin) )
        f(_vSnakeLogin, #selector(LoginViewController.handleSnakeLogin) )
        f(_vThirdLogin, #selector(LoginViewController.handleThirdPartyLogin) )
        f(_vPhoneNotGuestLogin, #selector(LoginViewController.handlePhoneLogin) )
        f(_vSnakeNotGuestLogin, #selector(LoginViewController.handleSnakeLogin) )
        f(_vThirdNotGuestLogin, #selector(LoginViewController.handleThirdPartyLogin) )
        
    }
    private func _addBorderForViews() {
        let border = Border(size: 1, color: Meta.borderColor, offset: UIEdgeInsets.zero)
        _vCurUser.borderTop = border
        _vCurUser.borderBottom = border
        _vCurUser.borderLeft = border
        _vCurUser.borderRight = border
    }
    
    private func _showViewContainer( view: UIView) {

        if view == _vLoginByType {
            _lblTitle.text = "loginWay".localized
            _vLoginByType.isHidden = false
            _vLoginByCurUser.isHidden = true
            _vLoginNotGuestType.isHidden = true

        } else if view == _vLoginNotGuestType {
            _lblTitle.text = "loginWay".localized
           _vLoginNotGuestType.isHidden = false
            _vLoginByType.isHidden = true
            _vLoginByCurUser.isHidden = true
           
        }
        else{
            _lblTitle.text = "returnLogin".localized
            _vLoginByCurUser.isHidden = false
            _vLoginByType.isHidden = true
            _vLoginNotGuestType.isHidden = true
        }
        
        
//        _vLoginByCurUser.hidden = !_vLoginByType.hidden
//        _vLoginNotGuestType.hidden = !_vLoginNotGuestType.hidden

    }
    
    
    func _setCurrentAccount(user: User) {
        
        var iconName: String = ""
        
        switch LoginBy(rawValue: user.type)! {
        case .Guest:
            iconName = "lkt0wer_usercenter_guest.png"
            
        case .Phone:
            iconName = "lkt0wer_snake_phone_account_manage_-1.png"
            
        case .Snake:
            iconName = "lkt0wer_snake_account_channel.png"
            
        case .ThirdParty:
            iconName = "lkt0wer_snake_account_channel.png"
        default:
            break
            
        }
        
        _imgCurUser.image = UIImage(named: iconName)
        _lblCurUser!.text = user.account
    }
    
    private func _setUIElements() {
        _addGestureForViews()
        
        guard let account = Cache.sharedInstance.currentUser else   {
            _showViewContainer(view: _vLoginByType)
            return
        }
        
        guard Store.sharedInstance.count() > 0 else {
            _showViewContainer(view: _vLoginByType)
            return
        }
        
        guard let u = Store.sharedInstance.user(account: account) else {
            _showViewContainer(view: _vLoginByType)
            return
        }
        

        _addBorderForViews()
        _setCurrentAccount(user: u)
        _showViewContainer(view: _vLoginByCurUser)
       
        _users = Store.sharedInstance.users()
        _count = _users!.count
        
        if _count == 0 {
            _btnLogin.isEnabled = false
        }
        
        //http://blog.csdn.net/kylinbl/article/details/9089227
        _vCachedAccount.isHidden = true

        _vWorkArea.layer.zPosition = 999
        _vCachedAccount.layer.zPosition = 999
        _vCachedAccount.layer.isOpaque = false
        
        
        let layer = _vCachedAccount.layer;
        
        layer.masksToBounds = true
        layer.cornerRadius = 2.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightGray.cgColor

//        //background
//        _vCachedAccount.backgroundView = UIView()
//        _vCachedAccount.backgroundView!.backgroundColor = UIColor.redColor()

    }
    
    private func _showCachedAccountView( status: Bool) {
        _vCachedAccount.isHidden = status
        _btnLogin.isEnabled = status
        _btnSwitchAccount.isEnabled = status
    }

    
    @objc func handleMoreUser() {
        var frame = _vCachedAccount.frame
        
        //move to somelse ?
        if _count < 3 {
            frame.size.height = CGFloat(_rowHeight * _count)
        }
        else{
            frame.size.height = CGFloat(_rowHeight * 3)
        }
        _vCachedAccount.frame = frame
        _showCachedAccountView(status: false)
        
    }
    
    
    
    //当前选择的用户
    func accountChoosed( id : Int64 ) ->Void {
        guard let user = Store.sharedInstance.userWithID(id: Int(id)) else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "LoginViewController",
                "action":    "currentAccountID",
                ])
            return
        }
        _setCurrentAccount(user: user)

        
    }
    
    @IBAction func onLoginClicked(sender: AnyObject) {
        let curUser = _lblCurUser.text!
//        print("onLoginClicked", curUser)
        
        if _count == 0 {
            return
        }
        guard let user = Store.sharedInstance.user(account: curUser) else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "LoginViewController",
                "action":    "onLoginClicked"
                ])
            return
        }
        Cache.sharedInstance.currentUser = user.account
        
        switch LoginBy(rawValue: user.type )! {
        case LoginBy.Guest :
            Snake.sharedInstance.guestLogin(  transparent: context.transparent)  {( _ :Result<SnakeUserInfo>)->Void in}
            
        case .Phone:
            Snake.sharedInstance.phoneAutoLogin(  transparent: context.transparent)  {( _ :Result<SnakeUserInfo>)->Void in}
            
        case .Snake:
            Snake.sharedInstance.snakeAutoLogin(  transparent: context.transparent )  {( _ :Result<SnakeUserInfo>)->Void in}
            
        case .ThirdParty:
            Snake.sharedInstance.thirdPartyAutoLogin( transparent: context.transparent )  {( _ :Result<SnakeUserInfo>)->Void in}
        default:
            break
        }
        
        
    }
    
    @IBAction func onSwitchAccountClicked(_ sender: UIButton) {
        let curUser = _lblCurUser.text!
        //        print("onLoginClicked", curUser)
        
        if _count == 0 {
            return
        }
        guard let user = Store.sharedInstance.user(account: curUser) else {
            SnakeLogger.sharedInstance.error(dictionary: [
                "component": "LoginViewController",
                "action":    "onLoginClicked"
                ])
            return
        }
        Cache.sharedInstance.currentUser = user.account
        
        for item in _users! {
            if item.type == 1 {
                _showViewContainer(view: _vLoginNotGuestType)
                return
            }
            _showViewContainer(view: _vLoginByType)
            
        }

    }
    

    
    @objc func handleGuestLogin() {
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController else {
            return
        }
        vc.context = context
        if #available(iOS 8.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            vc.modalPresentationStyle = .currentContext
        }
        UIViewController.topMostViewController()!.definesPresentationContext = true
        
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
        
    }
    
    @objc func handlePhoneLogin() {

        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "PhoneFillViewController") as? PhoneFillViewController else {
            return
        }
        vc.context = context
        if #available(iOS 8.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            vc.modalPresentationStyle = .currentContext
        }
        UIViewController.topMostViewController()!.definesPresentationContext = true
        
        UIViewController.topMostViewController()!.present(vc, animated: true) {
           self.view.isHidden = true
        }
 
    }
    
    @objc func handleSnakeLogin() {
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "SnakeLoginOrBindingViewController") as? SnakeLoginOrBindingViewController else {
            return
        }
        vc.context = context
        if #available(iOS 8.0, *) {
            vc.modalPresentationStyle = .overCurrentContext
        } else {
            vc.modalPresentationStyle = .currentContext
        }
        UIViewController.topMostViewController()!.definesPresentationContext = true
        
        UIViewController.topMostViewController()!.present(vc, animated: true) {
            self.view.isHidden = true
        }
    }
    
    @objc func handleThirdPartyLogin() {
        guard let vc = UIStoryboard(name: "SnakeSDK", bundle: nil).instantiateViewController(withIdentifier: "ThirdPartyLoginViewController") as? ThirdPartyLoginViewController else {
            return
        }
        
        vc.context = context
        UIViewController.topMostViewController()!.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        _setUIElements()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {

        _showCachedAccountView(status: true)
    }
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _IDAccountChooseViewCell) as! AccountChooseViewCell
        
        let user = _userAtIndex(idx: indexPath.row)
        cell.configure(user: user)
       
        if indexPath.row == _count - 1 {
            cell.addDropShadow()
            
        } else {
            cell.removeDropShadow()
        }

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curCell = self._vCachedAccount.cellForRow(at: indexPath)!
        
        let tag = Int64(curCell.tag)
        
        _showCachedAccountView(status: true)
        print("tableView tag" , tag )
        
        accountChoosed(id: tag)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onDeleteClicked(sender: UIButton) {
        _deleteUser(id: Int64(sender.tag))
        
        if _count <= 0 {
           _showViewContainer(view: _vLoginByType)
        }
        _vCachedAccount.reloadData()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        _showCachedAccountView(status: true)
        print("tochesend")

    }
    
}
