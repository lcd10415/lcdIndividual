//
//  SingleFile.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "SingleFile.h"

@interface SingleFile()<NSCoding>

@end

@implementation SingleFile

//编码
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_address forKey:@"address"];
    [coder encodeInteger:_age forKey:@"age"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name    = [coder decodeObjectForKey:@"name"];
        _address = [coder decodeObjectForKey:@"address"];
        _age     = [coder decodeIntForKey:@"age"];
    }
    return self;
}
@end
