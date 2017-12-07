//
//  Signuture.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/11/10.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Signuture.h"
static CGPoint midpoint(CGPoint p0,CGPoint p1){
    return (CGPoint){
        (p0.x + p1.x)/2.0,
        (p0.y + p1.y)/2.0
    };
}

@implementation Signuture
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self drawLayer];
    }
    return self;
}

- (void)drawLayer{
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    pan.maximumNumberOfTouches = pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
}
-(void)panGesture:(UIPanGestureRecognizer*)pan{
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint previousPoint = CGPointZero;
    CGPoint midPoint = midPoint(previousPoint,currentPoint);
    NSLog(@"获取到的触摸点的位置为--currentPoint:%@",NSStringFromCGPoint(currentPoint));
    [self.currentPointArr addObject:[NSValue valueWithCGPoint:currentPoint]];
    self.hasSignatureImg = YES;
    CGFloat viewHeight = self.frame.size.height;
    CGFloat currentY = currentPoint.y;
    if (pan.state ==UIGestureRecognizerStateBegan) {
        [path moveToPoint:currentPoint];
        
    } else if (pan.state ==UIGestureRecognizerStateChanged) {
        [path addQuadCurveToPoint:midPoint controlPoint:previousPoint];
        
        
    }
    
    if(0 <= currentY && currentY <= viewHeight)
    {
        if(max == 0&&min == 0)
        {
            max = currentPoint.x;
            min = currentPoint.x;
        }
        else
        {
            if(max <= currentPoint.x)
            {
                max = currentPoint.x;
            }
            if(min>=currentPoint.x)
            {
                min = currentPoint.x;
            }
        }
        
    }
    
    previousPoint = currentPoint;
    //记得调用,及时刷新视图
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
