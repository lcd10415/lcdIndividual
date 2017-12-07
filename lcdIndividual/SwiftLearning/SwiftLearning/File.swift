//
//  File.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/8/28.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
import Foundation

struct Dream {
static let psychosexualityFriend = { (name: String,age: Int,hobby:String) in
    guard (age < 28) && (age > 18) else{
        return
    }
    print("This is my psychosexuality Friend" + name + hobby + "\(age)")
    
 }
}
//class Foo {
//    var myPropertyValue = 0
//    var myProperty:Int{
//        get{
//            
//        }
//        //
//        set{
//            
//            
//        }
//    }
////    另外注意：根据苹果的注释，在初始化方法中设置属性不会调用 willSet 和 didSet：
////    willSet and didSet observers are not called when a property is first initialized.
////    They are only called when the property’s value is set outside of an initialization context.
//    var otherProperty:Int{
//        var newProperty = 0{
//            didSet{
//                print("myProperty的值从\(oldValue)更改为\(newProperty)")
//            }
//        }
//    }
//    
//    
//}

