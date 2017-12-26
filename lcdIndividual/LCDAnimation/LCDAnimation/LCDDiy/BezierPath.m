//
//  BezierPath.m
//  LCDAnimation
//
//  Created by ReleasePackageMachine on 2017/12/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "BezierPath.h"

@implementation BezierPath

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    [bezierPath moveToPoint:CGPointMake(20, 40)];
    [bezierPath addLineToPoint:CGPointMake(160, 160)];
    [bezierPath addLineToPoint:CGPointMake(140, 50)];
    [bezierPath closePath];

    shapeLayer.lineWidth = 2;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = nil;
    [self.layer addSublayer:shapeLayer];
    
    [bezierPath moveToPoint:CGPointMake(200, 50)];
    [bezierPath addQuadCurveToPoint:CGPointMake(300, 100) controlPoint:CGPointMake(320, 20)];
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = nil;
    shapeLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:shapeLayer];

    
}
@end
