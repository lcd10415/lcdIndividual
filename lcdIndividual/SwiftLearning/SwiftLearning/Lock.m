//
//  Lock.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/7.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Lock.h"

@implementation Lock


- (void)method1{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

-(void)method2{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
