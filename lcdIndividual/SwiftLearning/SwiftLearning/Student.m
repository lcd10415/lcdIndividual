//
//  Student.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Student.h"
#import "UIApplication+CurrentVC.h"

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)sss{
    //在需要用到的每个VC都需要添加此方法，可以基于这个类，作为基类，然后在viewWillAppear方法中添加，其他新建的vc，只需要继承.
    [UIApplication sharedApplication].currentVC = self;
//    这样，我们在任何一个地方获取，只需要添加如下代码，就可以获取当前的VC，获取到之后，不管是push、present还是performSegueWithIdentifier，都可以实现页面的跳转
    UIViewController * currentVC = [UIApplication sharedApplication].currentVC;
}
@end
