//
//  Subscript.swift
//  
//
//  Created by ReleasePackageMachine on 2017/12/14.
//

import Foundation

class Subscript: NSObject {
    var x = 0
    subscript(index: Int) ->Int{  //计算型属性，可以不指定setter的参数newValue
        get{
            //返回一个适当的Int类型的值
            return index + 10
        }
        set(newValue){ //newValue的类型和下标的返回烈性相同
            //执行适当的赋值操作
            x = newValue + 10
        }
    }
    func method1(){
        var numOfLegs = ["s":12,"w":21,"q":23]
        numOfLegs["p"] = 123
    }
    
}
