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
        
        let arr = [["image": "2","title":"醉玲珑","subTitle":"玩玩sgnkldglsdpgpdsmgpdsmgmsd;lgmdls;mgdlsmgopjemw"],
                   ["image": "2","title":"大哥大","subTitle":"犯困qemnrkqwrjmoq3jm4oijqpofjkaopkoprkwoprqe"],
                   ["image": "3","title":"小姐姐","subTitle":"喜欢dgmakdrlojqm发分头谈完i哦人呢哦i问你"],
                   ["image": "4","title":"荒野行动","subTitle":"沉迷按付款老i孔i秦啊今晚i哦提高i高i啊买那个i哦爱哦今日陪我干嘛快速公交"],
                   ["image": "5","title":"绝地求生","subTitle":"热爱昂哈诶哦啊工科男刚好i康行内哦那个i哦昂你噢安 那个闹归闹哦阿黑哥"],
                   ["image": "6","title":"英雄联盟","subTitle":"痴迷干嘛两个吗破啊我就破乳剂奥陪我看破奥陪我太奇葩问哇"],
                   ["image": "7","title":"DNF","subTitle":"讨厌"],]
        
        for (_,value) in arr.enumerated() {
                var temp:[LCDCellModel] = []
                temp.append(LCDCellModel.init(dict: value))
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
        let str = "店家了第\(indexPath.section)组第\(indexPath.row)行"
        print(str)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    func titleForHeaderInSection(section: Int) -> String {
            return "第\(section+1)组"
    }
    func titleForFooterInSection(section: Int) -> String {
        return ""
    }
    
}
