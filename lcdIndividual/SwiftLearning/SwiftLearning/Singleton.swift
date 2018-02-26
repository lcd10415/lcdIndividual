//
//  Singleton.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/7/14.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
struct knowledge {
    public func insertSort( arr: inout [Int]) -> [Int] {
        for i in 1..<arr.count {
            let key = arr[i]
            var j = i - 1
            while j >= 0 && arr[j] > key {
                arr[j+1] = arr[j];
                j = j-1;
            }
            arr[j+1]=key
        }
        return arr
    }
}
