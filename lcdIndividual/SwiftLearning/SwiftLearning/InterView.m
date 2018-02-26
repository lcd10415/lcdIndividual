//
//  InterView.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "InterView.h"
//多使用类型常量，少用#define预处理指令
NSString *const InterConstant = @"value";
static const NSTimeInterval kAnimationDuration = 0.3; //若常量在某一个单独的实现文件里面，命名前面加k,若常量在类之外可见，通常以类名作为前缀
@interface InterView()
@property(nonatomic,copy)NSString * name;
@property(nonatomic,assign)NSInteger * uid;
@end
@implementation InterView
- (instancetype)initWithName:(NSString *)name Uid:(NSInteger)uid
{
    self = [super init];
    if (self) {
        _name = name;
        _uid  = &uid;
        _name = [NSString stringWithFormat:@"%f",kAnimationDuration];
    }
    return self;
}

- (void)testNotificationQueue{
    // NSNotificationCenter和NSNotificationQueue最大的区别是一个同步一个是异步。
    NSNotification * notification = [[NSNotification alloc] initWithName:@"NotificationName" object:nil userInfo:@{@"key":@"value"}];
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostWhenIdle];
    //尽快发送NSPostASAP  空闲时发送NSPostWhenIdle   立即发送NSPostNow
    
//    NSNotificationCenter 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationMethod:) name:@"NotificationName" object:nil];
}
-(void)notificationMethod:(NSDictionary *)nodification{
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NotificationName" object:nil];
}

//在其他界面发送通知的代码

- (void)postNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName" object:nil userInfo:@{@"key":@"value"}];
}
@end
