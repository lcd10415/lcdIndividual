//
//  LCDCommon.swift
//  MVVM-Test
//
//  Created by Liuchaodong on 2018/3/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
struct Information {
    static let headerInfo = [["imageName":"2","title":"hello"],
                             ["imageName":"3","title":"hello"],
    ["imageName":"4","title":"hello"],
    ["imageName":"5","title":"hello"],
    ["imageName":"6","title":"hello"],
    ["imageName":"7","title":"hello"],
    ["imageName":"4","title":"hello"]]
    static func getHeaderInfo() -> [LCDCollectionModel] {
        var arrModel:[LCDCollectionModel] = []
        for (_,value) in headerInfo.enumerated() {
            let model = LCDCollectionModel.init(dict: value)
            arrModel.append(model)
        }
        return arrModel
    }
}
