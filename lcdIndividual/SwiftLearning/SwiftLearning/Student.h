//
//  Student.h
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property(nonatomic,assign)NSInteger  number;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * sex;
@property(nonatomic,assign)NSInteger  age;
@property(nonatomic,strong)NSString * address;
@property(nonatomic,strong)NSData * photo;
@end
