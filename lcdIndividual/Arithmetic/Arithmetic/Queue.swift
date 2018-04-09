//
//  Queue.swift
//  Arithmetic
//
//  Created by Liuchaodong on 2018/4/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
public struct Queue<T>{
//    队列是遵循先来先服务原则的一组有序的项。队列在尾部添加新元素，并从顶部移除元素。
    fileprivate var queueArr = [T]()
    init(arr: [T]) {
        self.queueArr = arr
    }
    //count
    public var count: Int{
        return self.queueArr.count
    }
    
    //isEmpty
    public var isEmpty: Bool{
        return self.queueArr.isEmpty
    }
    
    //front element
    public var font: T?{
        if isEmpty {
            print("queue is empty")
            return nil
        } else {
            return self.queueArr.first
        }
    }
    
    //add element
    public mutating func addElement(_ element: T){
        self.queueArr.append(element)
    }
    
    //remove element 在顶部移除元素
    public mutating func removeElement() -> T?{
        if isEmpty {
            print("queue is empty")
            return nil
        } else {
            return self.queueArr.removeFirst()
        }
    }
    public mutating func printAllElement(){
        guard self.count > 0 else {
            print("queue is empty")
            return
        }
        print("queue's all element: ")
        for (index,value) in self.queueArr.enumerated() {
            print("Index = \(index), Value = \(value)")
        }
    }
}





































