//
//  Test.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/1.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//
#import "Lock.h"

#import "Test.h"
//理解Runtime
//在Runtime中，对象可以用C语言中的结构体表示，而方法可以用C函数来实现，另外加上一些额外的特性。这些结构体和函数被runtime函数封装后，让OC的面向对象成为可能。
//当程序执行[object doSomething]时，会向消息接受者object发送一套消息,runtime会根据消息接受者是否能响应应该消息而做出不同的反应。
//objc/runtime.h中objc_class是表示一个雷的实例的结构体

@implementation Test

//主线程
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self test1];
    }
    return self;
}
-(void)test1{
    Lock *obj = [[Lock alloc] init];
    NSLock * lock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        [obj method1];
        sleep(10);
        [lock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        [obj method2];
        sleep(10);
        [lock unlock];
    });
    
}
- (void)test2{
    Lock * obj = [[Lock alloc] init];
    
    __block pthread_mutex_t mutex;
    pthread_mutex_init(&mutex,NULL);
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        pthread_mutex_lock(&mutex);
        [obj method1];
        sleep(5);
        pthread_mutex_unlock(&mutex);
    });
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        pthread_mutex_lock(&mutex);
        [obj method2];
        pthread_mutex_unlock(&mutex);
    });
}

@end
