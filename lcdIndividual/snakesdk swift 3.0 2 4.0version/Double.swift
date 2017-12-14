//
//  Double.swift
//  snakesdk
//
//  Created by tgame on 16/8/3.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
}
