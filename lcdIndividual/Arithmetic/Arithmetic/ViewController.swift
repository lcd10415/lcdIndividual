//
//  ViewController.swift
//  Arithmetic
//
//  Created by Liuchaodong on 2018/4/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //字典的声明
        //a empty dictionary
        var dict1 = Dictionary<String, AnyObject>()
        var dict2 = [String: AnyObject]()
        var dict3 = ["":""]
        
        getLinkList()
        getStackData()
        getQueueData()
    }

    //数组遍历
    func arrayTraverse() {
        var numbers: [Int] = [2,1,23,565,234,767,121]
        //1.
        for value in numbers {
            if let index = numbers.index(of: value)  {
                print("Index = \(index), value = \(value)")
            }
        }
        //2.
        numbers.forEach { (value) in
            if let index = numbers.index(of: value){
                print("Index = \(index), value = \(value)")
            }
        }
        //3.
        for (index,value) in numbers.enumerated() {
                print("Index = \(index), value = \(value)")
        }
        numbers.append(12)
        numbers.insert(222, at: 2)
        numbers.swapAt(2, 3)
        numbers.remove(at: 0)
        numbers.removeFirst()
        numbers.removeAll()
    }
    
    func getLinkList(){
        let list = LinkedListNode<String>(value: "s")
        print(list.isEmpty)
        print(list.first)
        print(list.count)
        
        list.appendToTail(value: "w")
        list.appendToTail(value: "i")
        list.appendToTail(value: "f")
        list.appendToTail(value: "t")
        
        print(list.printAllNodes())
        
        print(list.node(at: 0)!.value)
        print(list.node(at: 1)!.value)
        print(list.node(at: 2)!.value)
        print(list.node(at: 3)!.value)
    }
    
    func getStackData() {
        var stack = Stack(arr:[1,23,232,232,454,00])
        print(stack.printAllElement())
        stack.push(1)
        stack.push(444)
        print(stack.top)
        print(stack.printAllElement())
        stack.pop()
        stack.pop()
        print(stack.printAllElement())
    }
    
    func getQueueData() {
        var queue = Queue.init(arr: [1,2,3,4,5,6,7,8])
        print(queue.printAllElement())
        queue.addElement(12)
        queue.addElement(23)
        queue.addElement(44)
        print(queue.printAllElement())
        print(queue.font)
        print(queue.count)
        print(queue.removeElement())
        print(queue.removeElement())
        print(queue.printAllElement())
        print(queue.font)
        print(queue.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

