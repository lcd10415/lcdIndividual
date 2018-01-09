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

//Hashable协议实际上又需要实现Equatable协议
//对于NSObject类，默认就实现了Hashable协议,
//对于非NSObject类，我们需要遵循Hashable并根据==操作符的内容给出哈希算法
enum Department{
    case a, b
}
struct Demo {
    var name: String
    var department: Department
    var numbers = [1,2,5,1,55,32]
    
    mutating func test() -> Bool {
        numbers.swapAt(3, 4)
        switch department {
        case .a:
            print("this is a Department.a")
            return true
        case .b:
            print("this is a Department.b")
            return false
        }
    }
    //nil :通过赋值nil,你可以讲一个可选类型设置为无值状态
    var age: Int? = 8
    
    
    //在OC中，nil是一个指向不存在的对象的指针。 在swift中,nil不是一个指针，是一个不存在值的特定类型的。
    //任何数据类型的可选类型都可以设置为nil,不仅仅是对象类型
    var sex:String? //默认设置为nil
    
//    错误处理
//    do{
//        try canThrowAnError()
//    //  NO ERROR
//    }catch{
////   ERROR throw
//    }
}



















































