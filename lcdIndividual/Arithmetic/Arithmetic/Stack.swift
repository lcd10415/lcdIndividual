//
//  Stack.swift
//  Arithmetic
//
//  Created by Liuchaodong on 2018/4/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation

public struct Stack<T>{
    fileprivate var stackArr = [T]()
    
    public init(arr: [T]) {
        self.stackArr = arr
    }
    //count
    public var count: Int{
        return self.stackArr.count
    }
    public var isEmpty: Bool{
        return stackArr.isEmpty
    }
    
    //栈顶元素
    public var top: T?{
        if self.isEmpty {
            return nil
        } else {
            return self.stackArr.last
        }
    }
    
    //push operation
    public mutating func push(_ element: T){
        self.stackArr.append(element)
    }
    
    //pop operation
    public mutating func pop() -> T?{
        if isEmpty {
            print("stack is empty")
            return nil
        } else {
            //返回数组的最后一个元素
            return stackArr.removeLast()
        }
    }
    
    //打印所有元素
    
    public mutating func printAllElement(){
        guard self.count > 0 else {
            print("stack is empty")
            return
        }
        print("print all elements")
        for (index,value) in stackArr.enumerated() {
            print("Index = \(index),value = \(value)")
        }
    }
}
