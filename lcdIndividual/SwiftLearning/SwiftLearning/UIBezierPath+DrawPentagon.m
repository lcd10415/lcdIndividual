//
//  UIBezierPath+DrawPentagon.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/2/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "UIBezierPath+DrawPentagon.h"
//绘制五边形
@implementation UIBezierPath (DrawPentagon)
+(CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length{
    NSArray * lengths = @[@(length),@(length),@(length),@(length),@(length)];
    return [self drawPentagonWithCenter:center LengthArray:lengths];
}
+(CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)array{
    NSArray * coordinates = [self converCoordinateFromLength:array Center:center];
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    for (int i=0; i< [coordinates count]; i++) {
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        if (i == 0) {
            [bezierPath moveToPoint:point];
        }else{
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath closePath];
    return bezierPath.CGPath;
}
+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center{
    NSMutableArray *coordinateArr = [NSMutableArray array];
    for (int i = 0; i<lengthArray.count; i++) {
        double len = [[lengthArray objectAtIndex:i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point = CGPointMake(center.x - len*sin(M_PI/5.0), center.y);
        }
    }
    return coordinateArr;
}
@end
