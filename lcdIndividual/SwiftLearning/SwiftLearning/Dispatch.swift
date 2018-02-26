//
//  Dispatch.swift
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/18.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

import Foundation
import Dispatch
struct DispatchDemo{
    //create DispatchQueue
    func initQueue()  {
        let queue = DispatchQueue(label:"com.1ktower.queue")
        let label = "com.1ktower.queue" //队列的标识符，方便调试
        let qos = DispatchQoS.default //QoS的全称是quality of service。在Swift 3中，它是一个结构体，用来制定队列或者任务的重要性
        let attributes = DispatchQueue.Attributes.concurrent //
        if #available(iOS 10.0, *) {
            let autoreleaseFrequency = DispatchQueue.AutoreleaseFrequency.never//顾名思义，自动释放频率。有些队列是会在执行完任务后自动释放的，有些比如Timer等是不会自动释放的，是需要手动释放
            let queueFake = DispatchQueue.init(label: label, qos: qos, attributes: attributes, autoreleaseFrequency: autoreleaseFrequency, target: nil);
        } else {
            // Fallback on earlier versions
        }
//        队列的分类 主队列，全局队列
        let mainQueue      = DispatchQueue.main
        let globalQueue    = DispatchQueue.global()
        let globalQueueQos = DispatchQueue.global(qos: .userInitiated)
        //User Interactive 和用户交互相关，比如动画等等优先级最高。比如用户连续拖拽的计算
//        User Initiated 需要立刻的结果，比如push一个ViewController之前的数据计算
//        Utility 可以执行很长时间，再通知用户结果。比如下载一个文件，给用户下载进度。
//        Background 用户不可见，比如在后台存储大量数据
        
        
//        从任务的执行情况分为 串行 (serial)  并行(concurrent)
        let serialQueue     = DispatchQueue(label:"com.1ktower.queue")
        let concurrentQueue = DispatchQueue(label:"com.1ktower.queue",attributes:.concurrent)
        
//        async 提交一段任务到队列，并立刻返回
        serialQueue.sync {
            print("Main queue Start")
        }
        print("Main queue end")
    }
//    Qos
}
