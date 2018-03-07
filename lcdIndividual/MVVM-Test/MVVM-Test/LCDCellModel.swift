//
//  LCDCellModel.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/7.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
class LCDCellModel: NSObject{
    @objc  var image: String!
    @objc var title: String!
    @objc var subTitle: String!
    
    init(dict: [String: String]) {
        super.init()
        self.setValuesForKeys(dict )
    }
    class func LCDInfo(dict: [String: String]) -> LCDCellModel {
        return LCDInfo(dict:dict)
    }
}
