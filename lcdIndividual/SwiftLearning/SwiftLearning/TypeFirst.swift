 //
//  TypeFirst.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/8/14.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
struct LoadPlist {
    func readPlistFile(fileName: String) -> [String]{
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
        if let contents = NSArray(contentsOfFile: path) as? [String]{
            return contents
            }
        }
        return []
    }
}
		
