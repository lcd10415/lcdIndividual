//
//  NSRegularExpression.swift
//  snakesdk
//
//  Created by tgame on 16/7/28.
//  Copyright © 2016年 snakepop. All rights reserved.
//

import Foundation

// Short-hand regex extension
extension NSRegularExpression {
    func generalTest(toBeTested str: String) -> NSTextCheckingResult? {
        let range = NSMakeRange(0, str.characters.count)
        return self.firstMatch(in: str, options: .withTransparentBounds, range: range)
    }
}
