//
//  AbstractClass.m
//  snakesdk
//
//  Created by ReleasePackageMachine on 2017/9/4.
//  Copyright © 2017年 snakepop. All rights reserved.
//

#import "AbstractClass.h"
#import "txhd-Swift.h"
//#import "$(SWIFT_MODULE_NAME)-Swift.h"

//@interface AbstractClass : NSObject
//
//
//@end

@implementation AbstractClass
-(instancetype)getInstance{
    static AbstractClass * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AbstractClass alloc]init];
    });
    return instance;
}

-(int)login{
    [[SnakeSDK shareInstace] onLoginClickBySwiftWithTrans:@""];
    return 0;
}

@end
