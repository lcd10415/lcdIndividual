//
//  NestedTypes.swift
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/3/13.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
struct BlackjackCard {
    enum Suit: String {
        case spades = "ss",hearts = "qw",diamonds = "wew"
    }
    enum Rank: Int {
        case one = 1,two,three,four
        case jack,queen,king,ace
        struct Values {
            let first: Int,second: Int?
        }
        var values:Values {
            switch self {
            case .ace:
                return Values(first:1,second:11)
            case .queen,.jack,.king:
                return Values(first:10,second:nil)
            default:
                return Values(first: self.rawValue,second: nil)
            }
        }
    }
    let rank: Rank,suit:Suit
    var description: String{
        var output = "suit is \(suit.rawValue)"
        output    += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += "or \(second)"
        }
        return output
    }
}

class Instance {
    init() {
        let instance = BlackjackCard.init(rank: .king, suit: .diamonds)
        print(instance.description)
        let heart = BlackjackCard.Suit.hearts.rawValue
        print(heart)
        
        let rect = CGRect(origin: CGPoint(x:0,y:0),size: CGSize(width:10,height:10))
        let reat = CGRect(center: CGPoint(x:0,y:0),size: CGSize(width:12,height:22))
        reat.calculate {
            print("Liuchaodong")
        }
        rect.calculate {
            print("hello world")
        }
        
        printIntegerKinds([0,10,-2,1])
        
        var d6 = Dice(sides: 6,generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }
    }
    //class 关键字专门用在class类型的上下文的，可用来修饰类方法以及类的计算属性，class 不能出现在class的存储属性的
//    class func printIntegerKinds(_ numbers: [Int]){
        func printIntegerKinds(_ numbers: [Int]){
        for num in numbers {
            switch num.kind {
            case .zero:
                print("0")
            case .negative:
                print("-")
            case .positive:
                print("+")
            }
        }
    }
}

/*
 Extension functions
 Add computed instance properties and computed type properties
 Define instance methods and type methods
 Provide new initializers
 Define subscripts
 Define and use new nested types :classes,structures,enumerations
 Make an existing type conform to a protocol
 */
extension CGRect {
    //completed Properties
    var rectZ:CGRect{return .zero}
    //initializers
    init(center: CGPoint,size: CGSize) {
        let centerX = center.x - 10
        let centerY = center.y - 20
        
        self.init(center: CGPoint(x:centerX,y:centerY), size: size)
    }
    //() -> Void  which indicates a function that has no parameters and does not return a value
    func calculate(task:@escaping () -> Void) {
        for _ in 0 ..< Int(self.width) {
            task()
        }
    }
    subscript(index: Int) -> Int {
        var base = 1
        for _ in 0 ..< index {
            base *= 10
        }
        return (Int(self.width)/index)%10
    }
}

extension Int {
    enum Kind {
        case negative,zero,positive
    }
    var kind: Kind{
        switch self {
        case 0:
            return .zero
        case let x where x > 0: //正数
            return .positive
        case let x where x < 0: //负数
            return .negative
        default:
            return .zero
        }
    }
    
}

 protocol SomeProtocol {
    static var address: String{get set}
    static func addAddress()
    mutating func toggle()
    init()
}
class someSuperClass {
    init() {
    }
}
class someSubClsaa: someSuperClass,SomeProtocol {
    func toggle() {
    }
    
    static func addAddress() {
    }
    
    static var address: String{
        get{
            return ""
        }
        set{
            
        }
    }
    
    required override init(){
//        init implement
    }
}
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator //协议作为类型传值
    init(sides: Int,generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random()*Double(sides)) + 1
    }
}
//As a parameter type or return type in a function, method, or initializer
//As the type of a constant, variable, or property
//As the type of items in an array, dictionary, or other container
protocol RandomNumberGenerator{
    func random() -> Double
}

extension RandomNumberGenerator{
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 12.23
    let a = 233.2
    let c = 333.3
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom/m
    }
    
    
}






























































