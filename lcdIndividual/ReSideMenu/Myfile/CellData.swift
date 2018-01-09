//
//  CellData.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/4.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class CellData: NSObject {
    var data :AnyObject?
    var rowHeight: CGFloat?
    var cellIdentifier: String?
    convenience init(data :AnyObject?,rowHeight: CGFloat?,cellIdentifier: String?) {
        self.init()
        self.data = data
        self.rowHeight = rowHeight
        self.cellIdentifier = cellIdentifier
    }
}
