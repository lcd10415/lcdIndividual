//
//  InterView.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "InterView.h"

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
    }
    return self;
}
@end
