//
//  Arithmetic.swift
//  Arithmetic
//
//  Created by Liuchaodong on 2018/4/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import UIKit
import Foundation

public class LinkedListNode<T> {
    var value: T
    public typealias Node = LinkedListNode<T>
    //指向上一个节点
    weak var previousNod: LinkedListNode?
    //指向下一个节点
    var nextNode: LinkedListNode?
    public init(value: T){
        self.value = value
    }
    
    public var isEmpty: Bool{
        return head == nil
    }
    
    public var count: Int{
        guard var node = head else {
            return 0
        }
        var count = 1
        while let next = node.nextNode {
            node = next
            count = count + 1
        }
        return count
    }
    //头结点
    private var head: Node?
    public var first: Node?{
        return head
    }
    public var last: Node?{
        guard var node = head else {
            return nil
        }
        while let next = node.nextNode {
            node = next
        }
        return node
    }
    //获取index上的node
    public func node(at index: Int) -> Node? {
        if index == 0 {
            return head!
        } else{
            var node = head!.nextNode
            guard index < count else{
                return nil
            }
                for _ in 1..<index{
                    
                    node = node?.nextNode
                    if node == nil{
                        break
                    }
                }
            return node!
        }
    }
    //插入到最后一个节点
    public func appendToTail(value: T){
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previousNod = last
            lastNode.nextNode = newNode
        } else {
            head = newNode
        }
    }
    //插入到第一个节点
    public func insertToHead(value: T){
        let newNode = Node(value: value)
        if head == nil {
            head = newNode
        } else {
            newNode.nextNode = head
            head?.previousNod = newNode
            head = newNode
        }
    }
    //插入到指定下标
    /*
     在这种插入函数中，还是先判断该链表是否是空的，如果是，则无论index是多少(只要不小于0)，都插在链表的头部。如果不是空的，再判断index是否为0，如果是，则直接插在头部；如果index不为0，则判断index是否大于count，如果是，则无法插入；如果不是，则获取插入位置的前后节点进行重连。
     */
    public func insert(_ node: Node,at index: Int){
        if index < 0 {
            print("invalid input index")
            return
        }
        let newNode = node
        if count == 0 {
            head = newNode
        } else {
            if index == 0{
                newNode.nextNode = head
                head?.previousNod = newNode
                head = newNode
            } else {
                if index > count {
                    print("out of range")
                    return
                }
                let preN = self.node(at: index-1)
                let nextN = preN?.nextNode
                
                newNode.previousNod = preN
                newNode.nextNode = preN?.nextNode
                preN?.nextNode = newNode
                nextN?.previousNod = newNode
            }
        }
    }
    //移除节点: 链表寻址的第一个节点，
    public func removeAll(){
        head = nil
    }
    
    public func removeLast() -> T? {
        guard !isEmpty else {
            return nil
        }
        return remove(node: last!)
    }
    
    public func remove(node: Node) ->T?  {
        guard head != nil else {
            print("LinkList is empty")
            return nil
        }
        let preN = node.previousNod
        let nextN = node.nextNode
        
        if let preN = preN {
            preN.nextNode = nextN
        } else{
            head = nextN
        }
        
        nextN?.previousNod = preN
        node.previousNod = nil
        node.nextNode = nil
        return node.value
    }
    //打印所有节点
    public func printAllNodes(){
        guard head != nil else {
            print("linked list is empty")
            return
        }
        
        var node = head
        for index in 0..<count {
            if node == nil{
                break
            }
            print("index = \(index)")
            node = node!.nextNode
            print("node = \(node)"  )
        }
    }
}















































