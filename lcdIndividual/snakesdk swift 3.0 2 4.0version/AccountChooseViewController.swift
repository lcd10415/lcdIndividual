//
//  AccountChooseViewController.swift
//  snakesdk
//
//  Created by tgame on 16/7/18.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import UIKit


class AccountChooseViewController: UITableViewController {
    
    
    weak var delegate: AccountChooseDelegate?
    
    private var _users: [User]?
    private var _count = 0
    private let _IDAccountChooseViewCell = "AccountChooseViewCellID"
    
    private func _userAtIndex( idx: Int) -> User? {
        if idx >= _count {
            return nil
        }
        return _users?[idx]
        
    }
    
    private func _deleteUser(id: Int64) {
        for i in 0 ..< _users!.count {
            if _users?[i].id == id {
                _users?.removeAtIndex(i)
                _count -= 1
                break
            }
        }
        
        Store.sharedInstance.deleteUser(Int(id))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            _users = Store.sharedInstance.users()
            _count = _users!.count
        
        } catch let error {
            SnakeLogger.sharedInstance.error([
                "component": "AccountChooseViewController",
                "action":    "viewDidLoad",
                "error":     error
                ])
            
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.superview!.layer.cornerRadius = 0;
        super.viewWillAppear(animated)
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(_IDAccountChooseViewCell) as! AccountChooseViewCell
        
        let user = _userAtIndex(indexPath.row)
        cell.configure(user)
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let curCell = self.tableView!.cellForRowAtIndexPath(indexPath)!
        
        let tag = Int64(curCell.tag)
        
        //callback
        self.delegate?.accountChoosed(tag)
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil )

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
        _deleteUser(Int64(sender.tag))
        tableView.reloadData()
    }

}
