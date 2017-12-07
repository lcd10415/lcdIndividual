//
//  EnumType.swift
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/7/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
enum Enumeration {
    //枚举定义放在这里
}
enum alphabetA{
    case A
    case B
    case C
    case D
}
//或者
enum alphabet{
    case A,B,C,D
}
class Enumerationg : NSObject{
    //定义一个全新的类型
    var cA = alphabetA.A
    
    let charecterA = alphabetA.A
    
    func abc() {
        var charecterB = alphabetA.B
        charecterB = .C
        switch charecterB {
        case .A:
            print("this is \(charecterB) character")
        case .B:
            print("this is \(charecterB) character")
        case .C:
            print("this is \(charecterB) character")
        case .D:
            print("this is \(charecterB) character")
        }
    }
    
}
//类和结构体
class SomeClass{
    // 在这里定义类
}
struct SomeStruct {
    //在这里定义结构体
    //结构体属性访问通过点语法给属性赋值
}
//正方形
struct square{
    var length = 5
    var width = 5
}

//正方体
class cube{
    var squareA = square()
    var hight = 5
    func area() -> Int{
        return squareA.width*squareA.length*hight
    }
    
}
var squareB = square()
let cubeA = cube()
//squareB.width = 22

//与结构体不同，类实例没有默认的成员逐一构造器
let squareC = square(length:10,width:10)
//结构体和枚举是值类型
//值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
//值类型就是拷贝值，但完全是两个不同的实例，squareD只是squareC的一个拷贝副本
var squareD = squareC


//类是引用类型
//与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
let cubeB = cube()
cubeB.hight = 20
let cubeC = cubeB
cubeC.hight = 40
print("\(cubeB.hight)") //打印出40 cubeB和cubeC都是常量的值并未改变，他们不存储值，是对cube的引用，改变cube的hight属性，而不是引用cube的常量的值


//属性：存储属性和计算型属性
//计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
//默认构造器
//延迟存储属性:在属性声明前使用 lazy 来标示一个延迟存储属性,必须将延迟存储属性声明成变量（使用 var 关键字），因为属性的初始值可能在实例构造完成之后才会得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性
class cubold{
    lazy var squareB = square()
    var hight = 5
    func area() ->Int {
        return squareB.width*squareB.length*hight
    }
}
//简化setter声明
struct Point{
    var x = 0,y=0
}
struct Size {
    var width = 0,height = 0
    
}
//获取实例属性的值调用实例的getter 给实例属性赋值时调用实例的setter方法 
//只读计算属性：只能读取实例属性的值调用getter方法，没有setter方法  必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的
struct RectABC{
    var origin = Point()
    var size = Size()
    var center:Point{
        get{
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.height/2)
            return Point(x: centerX,y:centerY)
        }
        set{
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
    
}
var rect = RectABC()
rect.origin = Point(x:10,y:10)
rect.size = Size(width:10,height:10)
print("\(rect.center)")//调用的是getter方法
rect.center = Point(x:10,y:10)//调用setter方法


//属性观察者：属性观察着监控和相应属性值的变化，每次属性被设置值的时候都会调用属性观察器，及时新值和当前值相同也不例外

//willSet :在新值被设置之前调用
//didSet ：在新值被设置之后立即调用


//下标语法 定义在类、结构体和枚举中 
//一个类型可以多个下标，通过不同索引类型进行重载，下标不限于一维
struct indexTitle {
    var index = 0
    subscript(index: Int) -> Int {
        get{
//            返回一个适合的Int类型的值
              return 0
        }
        set(newValue){
            //同计算型属性
//            执行适当的赋值操作
          
        }
        
    }
    //同只读计算型属性， 可以省略只读下标的get关键字
    subscript(index: Int) ->Int{
        //返回一个适当的的Int类型的值
        return 0;
    }
}

//eg:
struct TimesTab{
    let multi:Int
    subscript(index: Int) ->Int{
        return multi*index
    }
}
let threeTab = TimesTab(multi: 2) //利用默认构造器初始化，
print("\(threeTab[6])") //调用下标语法进行运算操作  用[]调用subscript方法

//继承：
//重写属性 提供setter，getter方法来任意继承来的属性 可以将一个继承来的只读属性重写为一个读写属性，只需要给属性提供setter和getter方法，但是不能将一个继承来的读写属性重写为只读属性
//如果你在重写属性中提供了 setter，那么你也一定要提供 getter。如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。
//重写属性的description方法需要在调用super.description
//不能为常量属性或者只读属性添加属性观察器，这些属性的值是不可修改的，不能设置willSet和didSet
//你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
//防止重写 用final修饰方法，属性或者下标



//description 在输出字符串、一些基本数据类型以及 OC 对象，我们都可以使用 NSLog 函数进行输出
//千万不要在 description 方法中同时使用 %@ 和 self，如果这样使用了，那么最终会造成程序死循环，原因是因为：如果使用了%@和self，代表要调用self的description方法，最终就是循环调用description方法，所以以下是错误的写法，不可取
//析构过程：析构器只适用于类类型，每个类最多只能有一个析构器
class Obj{
    deinit{
        //执行析构过程
    }
}

//错误处理 :在swift中，错误用符合Error协议类型的值来表示。抛出错误使用throw关键字
//swift中错误处理和其他语言中用try，catch和throw进行异常处理
//用throwing函数传递错误,由于 throws 语句会立即退出当前方法  do-cathch语句，try?或try！
func catchErrors() throws -> String
//使用Do-catchErrors处理错误处理
do{
    try expression
    statements
}catch condition1{

}catch condition2{
    statements
}
//将错误转换成可选值 try?将错误转化成可选值来处理错误
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

//指定清除操作
defer{
    
}

//类型检查符 is。若实例属于那个子类型，类型检查操作符返回 true，否则返回 false
//向下转型 as! as?


//枚举常被用于为特定类或结构体实现某些功能。类似的，枚举可以方便的定义工具类或结构体，从而为某个复杂的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结构体。
//扩展可以为已有类型添加计算型实例属性和计算型类型属性
//扩展可以添加构造器，方法，可变实例方法，下标，嵌套类型




























































































