//
//  Gradient.m
//  LCDAnimation
//
//  Created by ReleasePackageMachine on 2017/12/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Gradient.h"
#import <QuartzCore/QuartzCore.h>
@implementation Gradient

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    CAGradientLayer * gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(100, 100, 200, 200);
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor blueColor].CGColor,
                                                (id)[UIColor grayColor].CGColor,
                                                (id)[UIColor orangeColor].CGColor,
                                                (id)[UIColor brownColor].CGColor,
                                                (id)[UIColor yellowColor].CGColor
                                                , nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
