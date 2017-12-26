//
//  LCDAnimation.m
//  LCDAnimation
//
//  Created by ReleasePackageMachine on 2017/12/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "LCDAnimation.h"

#define PI 3.14159265358979323846

@implementation LCDAnimation

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    //画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddArc(context, 200, 220, 100, 0, PI, 1);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPoint leftPoint = CGPointMake(100, 220);
    CGPoint rightPoint = CGPointMake(300, 220);
    CGRect rect1 = CGRectMake(100, 220, 200, 180);
    CGContextStrokeRect(context, rect1);
    CGContextFillRect(context, rect1);
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, rect1);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetLineWidth(context, 2);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextAddArc(context, 200, 400, 100, 0, PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //贝赛尔曲线
    
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);
    CGPoint points[2];
    points[0] = CGPointMake(100, 265);
    points[1] = CGPointMake(300, 265);
//    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 100, 265);
    CGContextAddLineToPoint(context, 300, 265);
    CGContextSetLineWidth(context, 10);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(context, 4);
    CGContextAddArc(context, 250, 265, 20, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 2);
    CGContextAddArc(context, 250, 270, 5, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    
}
-(UIView*)drawSemicircle{
    UIView * semicircle = [[UIView alloc] init];
    UIBezierPath * path = [UIBezierPath bezierPath];
    //画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0);
    CGContextSetLineWidth(context, 1);
    CGContextAddArc(context, 0, 0, 20, 0, PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    return semicircle;
}

@end
