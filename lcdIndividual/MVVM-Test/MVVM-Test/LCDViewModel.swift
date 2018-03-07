//
//  LCDViewModel.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/7.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
class LCDViewModel: NSObject {
    var LCDInfo: [[LCDCellModel]] = []
    
    override init() {
        super.init()
        self.getInfo()
    }
    func getInfo(){
        let arr = [["image": "hero","title":"asds","subTitle":"1232"],
                   ["image": "hero","title":"asds","subTitle":"1232"],
                   ["image": "hero","title":"asds","subTitle":"1232"],
                   ["image": "hero","title":"asds","subTitle":"1232"],
                   ["image": "hero","title":"asds","subTitle":"1232"],
                   ["image": "hero","title":"asds","subTitle":"1232"],]
        for (i,_) in arr.enumerated() {
            var temp:[LCDCellModel] = []
            for item in arr[i]{
                temp.append(LCDCellModel.init(dict: [item.key: item.value]))
            }
            self.LCDInfo.append(temp)
        }
    }
    func numberOfSections() -> Int {
        return self.LCDInfo.count
    }
    func numberOfItemsInSection(section: Int) -> Int {
        return self.LCDInfo[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> LCDTableViewCell {
        let cell = LCDTableViewCell.cellWithTableView(tableView: tableView)
        cell.model = self.LCDInfo[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath){
        let cell = LCDTableViewCell.cellWithTableView(tableView: tableView)
        let str = "店家了第\(indexPath.section)组第\(indexPath.row)行"
        cell.lab.text = str
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    func titleForHeaderInSection(section: Int) -> String {
        if section == 0 {
            return "第一组"
        }
        return "第二组"
    }
    func titleForFooterInSection(section: Int) -> String {
        return "这是尾部标题"
    }
    
}
