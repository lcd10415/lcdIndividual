//
//  NewFeature.swift
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
import Foundation

struct NewFeature {
    let numbers = [1,2,3,4,5,6,7,8]
//    swift4.0可以把字符串写在一对"""中，这样字符串就可以写成多行
    let multilineString = """
                            sioafhjioajsio asfkap[sjglajdogognla
                            amfl;asmg;amgp
                            gal;g,;a,;,'
                            gal;g,a;g,;a
                            kwp[fktqwp[g
                            -134-;ag,m;ldm,g[2pj3rm
                            """
    // 当然，也可以使用 \ 来转义换行
    let escapedNewLine = """
                    To omit a line break, \
                    add a backslash at the end of a line.
                """
    func reference() {
        print("\(numbers[5...])")
    }
    
    //swift4.0可以把代码中所有的characters都去掉
    func removeCharacters() {
        let value = "one,two,three,four,five..."
        var i = value.startIndex
        while let comma = value[i..<value.endIndex].index(of: ",") {
            if value[i..<comma] == "two"{
                print("found it !")
            }
            i = value.index(after: comma)
        }
    }
    //把String当做Collection来用
    func strAsCollection(){
        let greeting = "Hello, 😜!"
        print("\(greeting.count)")
        for char in greeting {
            print(char)
        }
        //翻转字符串
        print(String(greeting.reversed()))
    }
    //在 Swift 4 中，做取子串操作的结果是一个 Substring 类型，它无法直接赋值给需要 String 类型的地方。必须用 String() 包一层，系统会通过复制创建出一个新的字符串对象，这样原字符串在销毁时，原字符串的 Buffer 就可以完全释放了。
    //mainView.titleLabel.text = String(small)
    func subString() {}
    
    //Key Paths
    struct Person {
        var name: String
    }
    struct Book {
        var title: String
        var authors: [Person]
        var primaryAuthor: Person{
            return authors.first!
        }
    }
    let abelson = Person(name:"Liuchaodong")
    let sussman = Person(name:"zhouhang")
    func reference1(){
        var oneBook = Book(title:"Structure of Data",authors:[abelson,sussman])
        print(oneBook)
        
        //使用key paths获取对象值
        print(oneBook[keyPath: \Book.title])
        
//        key paths 可以用于计算属性
        print(oneBook[keyPath: \Book.primaryAuthor.name])
        
//        key paths是对象，可以被存储和操纵
        oneBook[keyPath: \Book.title] = "Swift 4.0"
        let authorKeyPath = \Book.primaryAuthor
        print(type(of: authorKeyPath))
        let nameKeyPath = authorKeyPath.appending(path: \.name)
        print(oneBook[keyPath:nameKeyPath])
    }
    
    
//    当需要将一个对象持久化时，需要把这个对象序列化，往常的做法是实现 NSCoding 协议，写过的人应该都知道实现 NSCoding 协议的代码写起来很痛苦，尤其是当属性非常多的时候。
//        Codable其实是一个组合协议
    public typealias Codable = Decodable & Encodable
    struct Card: Codable{
        enum Suit: String, Codable{
            case clubs,spades,hearts,diamonds
        }
        enum Rank:Int, Codable{
            case ace = 1,two,three,four,five,six,seven,eight,nine,ten,jack,queen,king
        }
        var suit:Suit
        var rank:Rank
        func reference() {
            let hand = [Card(suit: .hearts,rank:.two),Card(suit:.diamonds,rank:.queen)]
        }
        
    }
//    加密操作
    func enCode(data:String)  {
        var encoder = JSONEncoder()
        let jsData = try? encoder.encode(data)
        String(data:jsData!,encoding:.utf8)
        
        var encoder1 = PropertyListEncoder()
        encoder1.outputFormat = .xml
        let proData = try? encoder1.encode(data)
        String(data:proData!,encoding:.utf8)
    }
    
    //解密操作
    func deCode(data: Data)  {
        var decoder = JSONDecoder()
        let jsData = try? decoder.decode([Card].self, from: data)
        print(jsData)
        
        var decoder1 = PropertyListDecoder()
        let jsData1 = try? decoder1.decode([Card].self, from: data)
        jsData1![0].suit
    }
    func dictInit() {
        let names = ["123","2131","sadewq"]
//        zip函数的作用就是把两个Sequence合并成一个key-value元组的Sequence
        let dict = Dictionary.init(uniqueKeysWithValues: zip(1..., names))
        print(dict) //[1:"123",2:"2131",3:"sadewq"]
    }
}
//    协议中可以使用where语句对关联类型进行约束
protocol protocolName where Self:UICollectionViewCell {
}
//protocolName要求它的实现者必须继承UICollectionViewCell,
//不是随便一个类型都能实现protocolName





















