//
//  ResideView.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/4.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class ResideView: UIView,UITableViewDataSource,UITableViewDelegate {
    
    
    
    var flage = 5
    var datas :[DataMode] = [DataMode]()
    
    var contentTab:UITableView!
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        contentTab                =  UITableView(frame:self.bounds)
        contentTab.delegate       = self
        contentTab.separatorStyle = .none
        self.addSubview(contentTab)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifyID = "ResideTabID"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifyID) as! ResideCell
        cell.title = ""
        cell.image1.image = UIImage(named: "sdas")
        return cell
    }
}
