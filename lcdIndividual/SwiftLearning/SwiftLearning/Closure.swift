//
//  Closure.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/7/27.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
//闭包：自包含的函数代码块，可以在代码中被传递和使用，swift中闭包与C和OC中的代码块(blocks)，匿名函数比较相识

//闭包是引用类型

/*
全局函数是一个有名字但不会捕获任何值的闭包
嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
Swift 的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下：

利用上下文推断参数和返回值类型
隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
参数名称缩写
尾随闭包语法
*/
//sorted 方法

/*
{ (parameters) -> returnType in
    statements
}*/
extension SomeTypes: SomeProtocol{//遵循的协议
    //为SomeTypes添加的新功能写在这里
}
//构造器
//如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们可以在扩展中的构造器里调用默认构造器和逐一成员构造器
//如果你定制的构造器写在值类型的原始实现中，上述规则将不再适用
//扩展可以为已有类型添加新的实例方法和类型方法
extension Int {
    mutating func square(){
        self = self*self
    }
}
//结构体和枚举类型中修改self或其属性的方法必须将改实现方法标注为mutating
//上述例子中为Int类型添加了一个名为square的可变方法，用于计算原始值的平方值

extension Int{
    subscript(index: Int) ->Int {
        var a = 5
        for _ in 0..<index{
            a *= 10
        }
        return (self/a)%10
        
    }
}

//调用的时候 100[2] 返回 0  

//扩展 嵌套类型
extension Int{
    enum Kind {
        case Negative,Zero, Positive
    }
    var kind:Kind{
        switch self {
        case 0:
            return .Zero
        case let x where x > 0://大于0
            return .Positive
        default:
            return .Negative
        }
    }
}


//协议Protocol
protocol ProtocolName1{
    //定义协议部分
}
protocol ProtocolName2{
    //定义协议部分
}

struct StructName:  ProtocolName1,ProtocolName2{
    //结构体定义部分
}
class ClassName: ProtocolName1,ProtocolName2 {
    //类定义部分
}
//如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读属性
//在协议中定义类型属性的视乎，总是使用static关键字作为前缀。除了static，还可以使用class关键字来声明类型属性
protocol OtherProtocol{
    static var property:Int{get set}
}

//swift mutating关键字 ；使用mutating关键字修饰方法是为了能在该方法中修改struct 或是enum的变量，在设计接口的时候也要考虑使用者程序的扩展性。多考虑使用mutating来修饰方法
protocol Example{
    var simple: String{get}
    mutating func adjust()
    
}
class ExampleClass: Example {
    var simple = "aaaaaaa"
    var another = "sdsdsdsdsd"
    //在class中实现带有mutating方法的接口是，不用mutating进行修饰，因为对于class来说，类的成员变量和方法都是透明的，所以不必使用mutating来修饰
    func adjust(){
        simple += "bbbbbbbb"
    }
}
enum SimpleEnum: ExampleProtocol {
    case First, Second, Third
    var simpleDescription: String {
        get {
            switch self {
            case .First:
                return "first"
            case .Second:
                return "second"
            case .Third:
                return "third"
            }
        }
        
        set {
            simpleDescription = newValue
        }
    }
    
    mutating func adjust() {
        
    }
}
struct SimpleStruct: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {    //*************************如果去掉struct里面的mutating，编译会报错说不能改变机构提的成员
        simpleDescription += "(adjusted)"
    }
}

//泛型：能够根据自定义的需求，编写出适用于任意类型、灵活可用的函数及类型。
class ClassName1{
    //T代表Int 和 String
    func swapTwoValue<T>(_ a:T,_b: T){
        let temp = a
        a = b
        b = temp
    }
}
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element){
        items.append(item)
    }
    mutating func pop() ->Element{
        return items.removeLast()
    }
}
var stackA = Stack<String>()
stackA.push("aaa")
stackA.pop()
//扩展泛型类型
extension Stack{
    var topItem: Element?{
        return items.isEmpty ? nil : items[items.count - 1]
    }
    
}

//swift标准库中定义了一个Equatable协议：任何遵循该协议的类型必须实现等式符(==)及不等符(!=),从而能对该类型的任意两个这进行比较。所有的swift标准库都自动支持Equatable协议
class AClass{
    func findIndex<T: Equatable>(of valueToFind: T,in array: [T]) -> Int? {
        for (index,value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
}
//findIndex(of: in:) 唯一的类型参数写作T: Equatable，任何符合Equatable协议的类型T


































































