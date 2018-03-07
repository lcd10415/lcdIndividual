//
//  ViewController.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/7.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{

    var viewModel: LCDViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LCDViewModel()
        self.tableView.tableHeaderView = LCDHeaderView(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:100))
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSections();
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsInSection(section: section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.tableView(tableView: tableView, cellForRowAtIndexPath:indexPath)
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.tableView(tableView: tableView, didSelectRowAtIndexPath: indexPath)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.tableView(tableView: tableView, heightForRowAtIndexPath:indexPath)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.titleForHeaderInSection(section: section)
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.viewModel.titleForFooterInSection(section: section)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

