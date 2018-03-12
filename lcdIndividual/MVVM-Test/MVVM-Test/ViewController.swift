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
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 70
        self.tableView.tableHeaderView = LCDHeaderView(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:100))
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(footerRefresh))
        
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
    @objc func headerRefresh(){
        print("下拉刷新")
        let arr = [["image": "7","title":"醉玲珑","subTitle":"玩玩"],
                   ["image": "5","title":"大哥大","subTitle":"犯困"],
                   ["image": "4","title":"小姐姐","subTitle":"喜欢"],
                   ["image": "3","title":"荒野行动","subTitle":"沉迷"],
                   ["image": "5","title":"绝地求生","subTitle":"热爱"],
                   ["image": "6","title":"英雄联盟","subTitle":"痴迷"],
                   ["image": "7","title":"DNF","subTitle":"讨厌"],]
        
        for (_,value) in arr.enumerated() {
            var temp:[LCDCellModel] = []
            temp.append(LCDCellModel.init(dict: value))
            self.viewModel.LCDInfo.append(temp)
        }
        self.tableView.reloadData()
        self.tableView.mj_header.endRefreshing()
    }
    @objc func footerRefresh(){
        print("尾部视图")
        self.tableView.mj_footer.endRefreshing()
    }

}

