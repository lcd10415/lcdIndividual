//
//  Block.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/11/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Block.h"



void (^BlockName)(NSString * name,int age); //定义block 返回值 + (^块名) + (参数s);
typedef void(^testBlock)();
void(^SomeBlock)(NSString * name);
//使用块
@interface Block()
@property (nonatomic,copy)testBlock block;

@end



@implementation Block

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    //块语句: 一个简单的小任务或是一个行为单元而不是一个方法的集合
    //这个代码段能够在作为值方法和函数中传递
    //从作用域中捕获值的能力
    BlockName = ^(NSString * name,int age){
        NSLog(@"hello world");
        NSLog(@"%@ + %d",name,age);
    };
    SomeBlock = ^(NSString * name){
        NSLog(@"%@",name);
    };
    //执行block
    SomeBlock(@"hello world");
    
    
    //块能够从封闭区域中捕获值
    int value = 4;
    void (^Block1)() = ^{
        NSLog(@"%d",value);
    };
    Block1();
    
//    使用__block 修饰变量共享存储
    __block int num = 100;
    void (^testBlock)() = ^{
        NSLog(@"%d",num);   //100
        num = 250;
    };
    testBlock();
    NSLog(@"now this num is equal to %d",num); //250
}
//相当于swift的闭包
//block作为函数参数
//在捕获时， 非常容易形成一个强引用循环 块对任何捕获的对象都保持强引用，包括自己
//尾随闭包
- (void)beginTaskWithName:(NSString *)name completion:(void (^)(void)) callBcak{
}

-(void)test{
    Block * __weak weakSelf = self;
    self.block = ^{
        [weakSelf setup]; //capture the weak reference to avoid the reference cycle
    };
}

//OS X和iOS 提供多种高并发性，两种任务调度机制：操作队列和中央调度
//GCD在调度队列调度块


//错误处理
- (void)handleError:(NSError *)err{
    if (err) {
        @try{
//            对一些可能会抛出异常的操作作异常处理
        }
        @catch (NSException *exception){
            //处理异常
        }
        @finally{
//            清理之类的操作
        }
    }
}

-(void)codeOrganization{
    //代码块
    NSURL * url = ({
        NSString * urlStr = [NSString stringWithFormat:@"======================"];
        [NSURL URLWithString:urlStr];
    });
    
#pragma mark -  是一个在类内部组织代码并且帮助你分组方法实现的好办法
//    不同功能组的方法
//    protocols 的实现
//    对父类方法的重写
    
#pragma clang 
    
}










































































@end
