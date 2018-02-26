//
//  Lock.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/7.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Lock.h"
#import "Block.h"

@implementation Lock


- (void)method1{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)method2{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
-(void)test{
    Block * obj = [[Block alloc]init];
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    //线程1
    dispatch_async(dispatch_get_global_queue(0, dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)), ^{
        [obj method1];
        sleep(10);
        dispatch_semaphore_signal(semaphore);
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [obj method2];
        dispatch_semaphore_signal(semaphore);
    });
}
@end
