//
//  DataMode.swift
//  ReSideMenu
//
//  Created by Liuchaodong on 2018/1/4.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class DataMode: NSObject {
    var name:  String = ""
    var age :  Int     = 3
    var sex :  String  = "Man"
    convenience init(name: String,age:Int,sex:String) {
        self.init()
        self.name = name
        self.age = age
        self.sex = sex
    }
}
