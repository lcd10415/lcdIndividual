//
//  LCDCollectionModel.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class LCDCollectionModel: NSObject {
    @objc var imageName: String!
    @objc var title    : String!
    init(dict: [String: Any]) {
        super.init()
        self.setValuesForKeys(dict)
    }
}
