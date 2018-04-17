//
//  DrowLine.m
//  线性动画
//
//  Created by rexsu on 2017/3/3.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "DrowLine.h"
#import "FireView.h"
#import "WPDrowAnimationLayer.h"
#import "HYPWheelView.h"
#import "BaseRequest.h"
#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
//蛋糕外框4条线位置
#define DangaoStar_X Windows_Width / 2-100
#define DangaoStar_Y Windows_Height/ 2-100
#define DangaoStar_MaxX Windows_Width / 2+100
#define DangaoStar_MaxY Windows_Height/ 2+100
#define Windows_Width [UIScreen mainScreen].bounds.size.width
#define Windows_Height [UIScreen mainScreen].bounds.size.height
#define People_Name @"彩票"
#define People_age @"中奖了"
#define Blessing @"中奖了"

@interface DrowLine ()
{
    CAShapeLayer * layer11;
    CAShapeLayer * layer22;
    NSMutableArray * layers1;
    NSMutableArray * layers2;
    
}
@property (nonatomic,strong)UIButton * name;
@property (nonatomic,strong)UIButton * blessing;
@property (nonatomic,weak)HYPWheelView *wheelView;
@end
@implementation DrowLine

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self actionAnimation];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [WPDrowAnimationLayer createAnimationLayerWithString:People_Name rect:CGRectMake(Windows_Width / 2 - 150, 180, 300, 150) view:self font:[UIFont systemFontOfSize:40] duretion:5];
        [WPDrowAnimationLayer createAnimationLayerWithString:Blessing rect:CGRectMake(Windows_Width / 2 - 150, Windows_Height - 100, 300, 150) view:self font:[UIFont systemFontOfSize:40] duretion:5];
        [WPDrowAnimationLayer createAnimationLayerWithString:People_age rect:CGRectMake(Windows_Width / 2 - 150, 290, 300, 150) view:self font:[UIFont systemFontOfSize:30] duretion:5];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}


-(void)actionAnimation{
    [self bigBox];
    [self smallBox];
}

-(void)bigBox{
    UIBezierPath * path     = [[UIBezierPath alloc]init];;
    
    //创建四个角的点
    CGPoint point1          = CGPointMake(10, 20);
    CGPoint point2          = CGPointMake(Windows_Width - 10, 20);
    CGPoint point3          = CGPointMake(Windows_Width - 10,Windows_Height - 20);
    CGPoint point4          = CGPointMake(10, Windows_Height - 20);
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point1];
    
    layer11    = [CAShapeLayer layer];
    layer11.path              = path.CGPath;
    layer11.fillColor=[UIColor clearColor].CGColor;//填充颜色
    layer11.strokeColor=[UIColor whiteColor].CGColor;//边框颜色
    [self.layer addSublayer:layer11];

    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.keyPath               = @"strokeEnd";
    animation.duration              = 2;
//    animation.byValue               = @(0);
//    animation.toValue               = @(1);
//    [layer addAnimation:animation forKey:nil];

    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.autoreverses = NO;
    [layer11 addAnimation:animation forKey:nil];

}
-(void)smallBox{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(20, 30);
    CGPoint point2              = CGPointMake(20, Windows_Height - 30);
    CGPoint point3              = CGPointMake(Windows_Width - 20,Windows_Height - 30);
    CGPoint point4              = CGPointMake(Windows_Width - 20, 30);
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    [path addLineToPoint:point1];
    
    layer22        = [CAShapeLayer layer];
    layer22.path                  = path.CGPath;
    layer22.fillColor             = [UIColor clearColor].CGColor;
    layer22.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer22];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 2;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer22 addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(nextAnimation) withObject:nil afterDelay:1.6];
}

-(void)nextAnimation{
    //创建4个开始路径
    CGPoint point1              = CGPointMake(20, 30);
    CGPoint point2              = CGPointMake(20, Windows_Height - 30);
    CGPoint point3              = CGPointMake(Windows_Width - 20,Windows_Height - 30);
    CGPoint point4              = CGPointMake(Windows_Width - 20, 30);
    //创建对应的4个结束路径
    CGPoint endPoint1              = CGPointMake(Windows_Width / 2-100, Windows_Height/2-100);
    CGPoint endPoint4              = CGPointMake(Windows_Width / 2+100, Windows_Height/2-100);
    CGPoint endPoint3              = CGPointMake(Windows_Width / 2+100,Windows_Height/2+100);
    CGPoint endPoint2              = CGPointMake(Windows_Width / 2-100, Windows_Height/2+100);
    
    layers1 = [NSMutableArray arrayWithCapacity:4];
    CAShapeLayer * shapeLayer1 = [self drowLineWithByPath:point1 toPath:endPoint1];
    CAShapeLayer * shapeLayer2 = [self drowLineWithByPath:point2 toPath:endPoint2];
    CAShapeLayer * shapeLayer3 = [self drowLineWithByPath:point3 toPath:endPoint3];
    CAShapeLayer * shapeLayer4 = [self drowLineWithByPath:point4 toPath:endPoint4];
    [layers1 addObject:shapeLayer1];
    [layers1 addObject:shapeLayer2];
    [layers1 addObject:shapeLayer3];
    [layers1 addObject:shapeLayer4];
    
    [self performSelector:@selector(nextAnimation2) withObject:nil afterDelay:0.4];
    
}

-(void)nextAnimation2{
    CGPoint point1              = CGPointMake(Windows_Width / 2-100, Windows_Height/2-100);
    CGPoint point2              = CGPointMake(Windows_Width / 2+100, Windows_Height/2-100);
    CGPoint point3              = CGPointMake(Windows_Width / 2+100,Windows_Height/2+100);
    CGPoint point4              = CGPointMake(Windows_Width / 2-100, Windows_Height/2+100);
    //创建对应的4个结束路径
    CGPoint endPoint2              = CGPointMake(Windows_Width / 2-100, Windows_Height/2-100);
    CGPoint endPoint3              = CGPointMake(Windows_Width / 2+100, Windows_Height/2-100);
    CGPoint endPoint4              = CGPointMake(Windows_Width / 2+100,Windows_Height/2+100);
    CGPoint endPoint1              = CGPointMake(Windows_Width / 2-100, Windows_Height/2+100);
    
    layers2 = [NSMutableArray arrayWithCapacity:4];
    CAShapeLayer * shapeLayer1 = [self drowLineWithByPath:point1 toPath:endPoint1];
    CAShapeLayer * shapeLayer2 = [self drowLineWithByPath:point2 toPath:endPoint2];
    CAShapeLayer * shapeLayer3 = [self drowLineWithByPath:point3 toPath:endPoint3];
    CAShapeLayer * shapeLayer4 = [self drowLineWithByPath:point4 toPath:endPoint4];
    [layers2 addObject:shapeLayer1];
    [layers2 addObject:shapeLayer2];
    [layers2 addObject:shapeLayer3];
    [layers2 addObject:shapeLayer4];
    [self performSelector:@selector(drowDangao) withObject:nil afterDelay:0.5];
}

-(void)round{
    
}

-(CAShapeLayer *)drowLineWithByPath:(CGPoint)byPath toPath:(CGPoint)toPath
{
    UIBezierPath * path     = [UIBezierPath bezierPath];
    [path moveToPoint:byPath];
    [path addLineToPoint:toPath];
    
    CAShapeLayer * layer    = [CAShapeLayer layer];
    layer.fillColor         = [UIColor clearColor].CGColor;
    layer.strokeColor       = ColorWithRGB(172, 60, 60).CGColor;
    layer.path              = path.CGPath;
    
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation  animationWithKeyPath:@"strokeEnd"];
    animation.duration              = 0.6;
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [layer addAnimation:animation forKey:nil];
    
    return layer;
}


//画蛋糕
-(void)drowDangao{
//    [self.wheelView start];
    HYPWheelView *wheel = [HYPWheelView wheelView];
    self.wheelView = wheel;
    wheel.center = self.center;
    [self addSubview:wheel];
    [self dangao1];
}
//底座
-(void)dangao1{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 5, DangaoStar_MaxY - 10);
    CGPoint point2              = CGPointMake(DangaoStar_MaxX - 5, DangaoStar_MaxY - 10);
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 6;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(176, 60, 61).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.5;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao2) withObject:nil afterDelay:0.1];
}
//底层
-(void)dangao2{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 15, DangaoStar_MaxY - 10);
    
    CGPoint point2              = CGPointMake(DangaoStar_X + 10, DangaoStar_MaxY - 50);
    
    
    CGPoint point3              = CGPointMake(DangaoStar_X + 15,DangaoStar_MaxY - 63);
    
    
    CGPoint point4              = CGPointMake(DangaoStar_X + 26, DangaoStar_MaxY - 70);
    
    //中转点
    CGPoint point5              = CGPointMake(DangaoStar_X + 100, DangaoStar_MaxY - 75);
    
    
    CGPoint point6              = CGPointMake(DangaoStar_MaxX - 26, DangaoStar_MaxY - 70);
    
    CGPoint point7              = CGPointMake(DangaoStar_MaxX - 15,DangaoStar_MaxY - 63);
    
    CGPoint point8              = CGPointMake(DangaoStar_MaxX - 10, DangaoStar_MaxY - 50);
    
    CGPoint point9              = CGPointMake(DangaoStar_MaxX - 15, DangaoStar_MaxY - 10);
    
    //添加直线
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    //添加贝赛尔曲线
    [path addCurveToPoint:point5 controlPoint1:point3 controlPoint2:point4];
    [path addCurveToPoint:point8 controlPoint1:point6 controlPoint2:point7];
    //添加曲线
    [path addLineToPoint:point9];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 6;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer];
    
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.5;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao3) withObject:nil afterDelay:0.1];
    
}
//底层波浪
-(void)dangao3{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 15, DangaoStar_MaxY - 48);
    CGPoint point2              = CGPointMake(DangaoStar_X + 30, DangaoStar_MaxY - 30);
    CGPoint point3              = CGPointMake(DangaoStar_X + 50,DangaoStar_MaxY - 50);
    
    CGPoint point4              = CGPointMake(DangaoStar_X + 65+2, DangaoStar_MaxY - 48-3);
    CGPoint point5              = CGPointMake(DangaoStar_X + 80-3, DangaoStar_MaxY - 30-2);
    CGPoint point6              = CGPointMake(DangaoStar_X + 95-6,DangaoStar_MaxY - 50-1);
    
    CGPoint point7              = CGPointMake(DangaoStar_X + 110+1, DangaoStar_MaxY - 48-1);
    CGPoint point8              = CGPointMake(DangaoStar_X + 125+3, DangaoStar_MaxY - 30+6);
    CGPoint point9              = CGPointMake(DangaoStar_X + 140-4,DangaoStar_MaxY - 50+5);
    
    CGPoint point11              = CGPointMake(DangaoStar_X + 155+1, DangaoStar_MaxY - 48+2);
    CGPoint point22              = CGPointMake(DangaoStar_X + 170+1, DangaoStar_MaxY - 30-2);
    CGPoint point33              = CGPointMake(DangaoStar_X + 185,DangaoStar_MaxY - 50+4);
    
    CGPoint point44              = CGPointMake(DangaoStar_MaxX - 15, DangaoStar_MaxY - 48);

    
    
    [path moveToPoint:point1];
    [path addCurveToPoint:point4 controlPoint1:point2 controlPoint2:point3];
    [path addCurveToPoint:point7 controlPoint1:point5 controlPoint2:point6];
    [path addCurveToPoint:point11 controlPoint1:point8 controlPoint2:point9];
    [path addCurveToPoint:point44 controlPoint1:point22 controlPoint2:point33];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 4;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.4;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao4) withObject:nil afterDelay:0.1];

}
//顶层
-(void)dangao4{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 40, DangaoStar_MaxY - 70);
    
    CGPoint point2              = CGPointMake(DangaoStar_X + 35, DangaoStar_MaxY - 90);
    
    
    CGPoint point3              = CGPointMake(DangaoStar_X + 45,DangaoStar_MaxY - 105);
    
    
    CGPoint point4              = CGPointMake(DangaoStar_X + 50, DangaoStar_MaxY - 110);
    
    //中转点
    CGPoint point5              = CGPointMake(DangaoStar_X + 100, DangaoStar_MaxY - 115);
    
    
    CGPoint point6              = CGPointMake(DangaoStar_MaxX - 50, DangaoStar_MaxY - 110);
    
    CGPoint point7              = CGPointMake(DangaoStar_MaxX - 45,DangaoStar_MaxY - 105);
    
    CGPoint point8              = CGPointMake(DangaoStar_MaxX - 35, DangaoStar_MaxY - 90);
    
    CGPoint point9              = CGPointMake(DangaoStar_MaxX - 40, DangaoStar_MaxY - 70);
    
    //添加直线
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    //添加贝赛尔曲线
    [path addCurveToPoint:point5 controlPoint1:point3 controlPoint2:point4];
    [path addCurveToPoint:point8 controlPoint1:point6 controlPoint2:point7];
    //添加曲线
    [path addLineToPoint:point9];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 6;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.5;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao5) withObject:nil afterDelay:0.1];
    
}
//顶层波浪
-(void)dangao5{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 35, DangaoStar_MaxY - 90);
    
    CGPoint point2              = CGPointMake(DangaoStar_X + 50+2, DangaoStar_MaxY - 85-1);
    CGPoint point3              = CGPointMake(DangaoStar_X + 65+1,DangaoStar_MaxY - 90-2);
    CGPoint point4              = CGPointMake(DangaoStar_X + 80-3, DangaoStar_MaxY - 100-3);
    
    CGPoint point5              = CGPointMake(DangaoStar_X + 95-1, DangaoStar_MaxY - 90+3);
    CGPoint point6              = CGPointMake(DangaoStar_X + 110+3,DangaoStar_MaxY - 85-1);
    CGPoint point7              = CGPointMake(DangaoStar_X + 125+1, DangaoStar_MaxY - 90+1);
    
    CGPoint point8              = CGPointMake(DangaoStar_X + 140+3, DangaoStar_MaxY - 100+2);
    CGPoint point9              = CGPointMake(DangaoStar_X + 155-4,DangaoStar_MaxY - 90-2);
    CGPoint point11              = CGPointMake(DangaoStar_X + 165, DangaoStar_MaxY - 85-1);
    
    
    
    [path moveToPoint:point1];
    [path addCurveToPoint:point4 controlPoint1:point2 controlPoint2:point3];
    [path addCurveToPoint:point7 controlPoint1:point5 controlPoint2:point6];
    [path addCurveToPoint:point11 controlPoint1:point8 controlPoint2:point9];

    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 4;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.5;
    
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao6) withObject:nil afterDelay:0.4];
    
}
//樱桃
-(void)dangao6{
    //画3个圆
    UIBezierPath * path1         = [UIBezierPath bezierPath];
    UIBezierPath * path2         = [UIBezierPath bezierPath];
    UIBezierPath * path3         = [UIBezierPath bezierPath];
    
    [path1 addArcWithCenter:CGPointMake(DangaoStar_X + 70,DangaoStar_MaxY - 122) radius:8 startAngle:0 endAngle:(2 * M_PI) clockwise:NO];
    [path2 addArcWithCenter:CGPointMake(DangaoStar_X + 100,DangaoStar_MaxY - 129) radius:10 startAngle:0 endAngle:(2 * M_PI) clockwise:NO];
    [path3 addArcWithCenter:CGPointMake(DangaoStar_X + 130,DangaoStar_MaxY - 121) radius:7 startAngle:0 endAngle:(2 * M_PI) clockwise:NO];
    //创建路径
    
    
    
    CAShapeLayer * layer1        = [CAShapeLayer layer];
    layer1.path                  = path1.CGPath;
    layer1.lineWidth             = 3;
    layer1.fillColor             = [UIColor clearColor].CGColor;
    layer1.strokeColor           = ColorWithRGB(240, 36, 79).CGColor;
    [self.layer addSublayer:layer1];
    
    CAShapeLayer * layer2        = [CAShapeLayer layer];
    layer2.path                  = path2.CGPath;
    layer2.lineWidth             = 3;
    layer2.fillColor             = [UIColor clearColor].CGColor;
    layer2.strokeColor           = ColorWithRGB(240, 36, 79).CGColor;
    [self.layer addSublayer:layer2];
    
    CAShapeLayer * layer3        = [CAShapeLayer layer];
    layer3.path                  = path3.CGPath;
    layer3.lineWidth             = 3;
    layer3.fillColor             = [UIColor clearColor].CGColor;
    layer3.strokeColor           = ColorWithRGB(240, 36, 79).CGColor;
    [self.layer addSublayer:layer3];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.3;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer1 addAnimation:animation forKey:nil];
    [layer2 addAnimation:animation forKey:nil];
    [layer3 addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao7) withObject:nil afterDelay:0.2];
    
}
//樱桃杆
-(void)dangao7{
    //绘制3端樱桃杆路径
    UIBezierPath * path1         = [UIBezierPath bezierPath];
    UIBezierPath * path2         = [UIBezierPath bezierPath];
    UIBezierPath * path3         = [UIBezierPath bezierPath];
    //创建路径
    
    //第一个杆子路径
    CGPoint point1      = CGPointMake(DangaoStar_X + 70,DangaoStar_MaxY - 125);
    CGPoint point2      = CGPointMake(DangaoStar_X + 66,DangaoStar_MaxY - 127);
    CGPoint point3      = CGPointMake(DangaoStar_X + 60,DangaoStar_MaxY - 129);
    [path1 moveToPoint:point1];
    [path1 addCurveToPoint:point3 controlPoint1:point2 controlPoint2:point3];
    //第二个杆子路径
    CGPoint point4      = CGPointMake(DangaoStar_X + 102,DangaoStar_MaxY - 134);
    CGPoint point5      = CGPointMake(DangaoStar_X + 104,DangaoStar_MaxY - 138);
    CGPoint point6      = CGPointMake(DangaoStar_X + 102,DangaoStar_MaxY - 146);
    [path2 moveToPoint:point4];
    [path2 addCurveToPoint:point6 controlPoint1:point5 controlPoint2:point6];
    //第三个杆子路径
    CGPoint point7      = CGPointMake(DangaoStar_X + 130,DangaoStar_MaxY - 124);
    CGPoint point8      = CGPointMake(DangaoStar_X + 134,DangaoStar_MaxY - 125);
    CGPoint point9      = CGPointMake(DangaoStar_X + 138,DangaoStar_MaxY - 126);
    [path3 moveToPoint:point7];
    [path3 addCurveToPoint:point9 controlPoint1:point8 controlPoint2:point9];
    
    
    CAShapeLayer * layer1        = [CAShapeLayer layer];
    layer1.path                  = path1.CGPath;
    layer1.lineWidth             = 2;
    layer1.fillColor             = [UIColor clearColor].CGColor;
    layer1.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer1];
    
    CAShapeLayer * layer2        = [CAShapeLayer layer];
    layer2.path                  = path2.CGPath;
    layer2.lineWidth             = 2;
    layer2.fillColor             = [UIColor clearColor].CGColor;
    layer2.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer2];
    
    CAShapeLayer * layer3        = [CAShapeLayer layer];
    layer3.path                  = path3.CGPath;
    layer3.lineWidth             = 2;
    layer3.fillColor             = [UIColor clearColor].CGColor;
    layer3.strokeColor           = ColorWithRGB(254, 131, 1).CGColor;
    [self.layer addSublayer:layer3];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.1;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer1 addAnimation:animation forKey:nil];
    [layer2 addAnimation:animation forKey:nil];
    [layer3 addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao8) withObject:nil afterDelay:0.1];
    
}
//蜡烛
-(void)dangao8{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 145,DangaoStar_MaxY - 110);
    CGPoint point2              = CGPointMake(DangaoStar_X + 155,DangaoStar_MaxY - 150);
    CGPoint point3              = CGPointMake(DangaoStar_X + 162,DangaoStar_MaxY - 148);
    CGPoint point4              = CGPointMake(DangaoStar_X + 152,DangaoStar_MaxY - 108);
    
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    [path addLineToPoint:point4];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.lineWidth             = 3;
    layer.path                  = path.CGPath;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(247, 88, 88).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.3;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(dangao9) withObject:nil afterDelay:0.2];
}
//火
-(void)dangao9{
    UIBezierPath * path         = [UIBezierPath bezierPath];
    //创建路径
    CGPoint point1              = CGPointMake(DangaoStar_X + 159,DangaoStar_MaxY - 153);
    CGPoint point2              = CGPointMake(DangaoStar_X + 155,DangaoStar_MaxY - 159);
    CGPoint point3              = CGPointMake(DangaoStar_X + 159,DangaoStar_MaxY - 167);
    CGPoint point4              = CGPointMake(DangaoStar_X + 163,DangaoStar_MaxY - 159);
    
    [path moveToPoint:point1];
    [path addCurveToPoint:point3 controlPoint1:point2 controlPoint2:point3];
    [path addCurveToPoint:point1 controlPoint1:point3 controlPoint2:point4];
    
    CAShapeLayer * layer        = [CAShapeLayer layer];
    layer.path                  = path.CGPath;
    layer.lineWidth             = 2;
    layer.fillColor             = [UIColor clearColor].CGColor;
    layer.strokeColor           = ColorWithRGB(242, 193, 34).CGColor;
    [self.layer addSublayer:layer];
    
    CABasicAnimation * animation    = [CABasicAnimation animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration              = 0.1;
    animation.keyPath               = @"strokeEnd";
    animation.fromValue             = @(0);
    animation.toValue               = @(1);
    
    [layer addAnimation:animation forKey:nil];
    
    [self performSelector:@selector(removeAllLine) withObject:nil afterDelay:0.5];
}

-(void)removeAllLine{
    [self remove1];
}

-(void)remove1{
    for (CAShapeLayer * layer in layers2) {
        
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 0.5;
        animation.fromValue = @(1);
        animation.toValue = @(0);
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [layer addAnimation:animation forKey:nil];
    }
    [self performSelector:@selector(remove2) withObject:nil afterDelay:0.4];
}
-(void)remove2{
    for (CAShapeLayer * layer in layers1) {
        
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.duration = 0.5;
        animation.fromValue = @(1);
        animation.toValue = @(0);
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [layer addAnimation:animation forKey:nil];
    }
    [self performSelector:@selector(remove3) withObject:nil afterDelay:0.4];
}
-(void)remove3{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer11 addAnimation:animation forKey:nil];
    [self remove4];
}
-(void)remove4{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2;
    animation.fromValue = @(1);
    animation.toValue = @(0);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer22 addAnimation:animation forKey:nil];
    [self performSelector:@selector(fireView) withObject:nil afterDelay:2];
}



-(void)fireView{
    [self performSelector:@selector(initFire) withObject:nil afterDelay:1];
    [self performSelector:@selector(drowTitle) withObject:nil afterDelay:5];
}

#pragma mark 画字
-(void)drowTitle{
//    [WPDrowAnimationLayer createAnimationLayerWithString:@"" rect:CGRectMake(Windows_Width / 2 - 150, Windows_Height - 200, 300, 150) view:self font:[UIFont systemFontOfSize:40] duretion:5];
}

-(UIButton *)name{
    if (!_name) {
        _name = [UIButton buttonWithType:UIButtonTypeCustom];
        _name.bounds = CGRectMake(0, 0, Windows_Width, 100);
        _name.center = CGPointMake(Windows_Width / 2, 120);
//        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:People_Name];
//        [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0,People_Name.length)];
//        //字体的设置
//        [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HanziPen SC" size:35] range:NSMakeRange(0, People_Name.length)];
//
//        [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:arc4random() %255/255 green:arc4random() %255/255 blue:arc4random() %255/255 alpha:1] range:NSMakeRange(0, People_Name.length)];
//        //空心字
//        [text addAttribute:NSStrokeWidthAttributeName value:@(1) range:NSMakeRange(6, 4)];
//        //改变填充字/空心字颜色(依附于填充字/空心字)
//        [text addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:NSMakeRange(6, 4)];
        [_name addTarget:self action:@selector(onStartClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _name;
}
-(void)onStartClicked:(UIButton *)sender{
   
}

-(void)initFire{
    self.backgroundColor = [UIColor blackColor];
    
    CAEmitterLayer * firelayer                  = [CAEmitterLayer layer];
    firelayer.position                          = CGPointMake(Windows_Width /2, Windows_Height - 10);
    firelayer.emitterSize                       = CGSizeMake(10, 0);
    firelayer.emitterMode                       = kCAEmitterLayerOutline;
    firelayer.emitterShape                      = kCAEmitterLayerLine;
    firelayer.renderMode                        = kCAEmitterLayerAdditive;
    
    //烟花
    CAEmitterCell * cell                        = [CAEmitterCell emitterCell];
    cell.birthRate                              = 2;
    cell.lifetime                               = 1.5;
    cell.lifetimeRange                          = 0.3;
    cell.velocity                               = 400;
    cell.velocityRange                          = 110;
    cell.contents                               = (id)[UIImage imageNamed:@"FFTspark"].CGImage;
    cell.color                                  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1].CGColor;
    cell.redRange                               = 0.4;
    cell.greenRange                             = 0.4;
    cell.blueRange                              = 0.4;
    cell.scale                                  = 0.2;
    cell.scaleRange                             = 0.1;
    //发射角度范围
    cell.emissionRange                          = M_PI /6;
    cell.spinRange                              = M_PI;
    cell.yAcceleration                          = 50;
    
    // 爆炸
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate                 = 2.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 1.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    //火花
    CAEmitterCell * fire                        = [CAEmitterCell emitterCell];
    //
    fire.birthRate                              = 400;
    //
    fire.velocity                               = 70;
    //spark.lifetime                            = 1.5;
    fire.lifetime                               = 1.5;
    //spark.contents                            = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    fire.contents                               = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    //
    fire.scaleSpeed                             = -0.1;
    //
    fire.greenSpeed                             = -0.05;
    //
    fire.redSpeed                               = 0.2;
    //
    fire.blueSpeed                              = -0.05;
    //
    fire.alphaSpeed                             = -0.18;
    //
    fire.spin                                   = 2* M_PI;
    //
    fire.spinRange                              = 2* M_PI;
    //发射角度（不可少的属性）
    fire.emissionRange                          = M_PI;
    
    
    firelayer.emitterCells                      = @[cell];
    
    cell.emitterCells                           = [NSArray arrayWithObject:burst];
    burst.emitterCells                          = @[fire];
    [self.layer addSublayer:firelayer];
    
    
}

-(void)initFireDemo{
    CAEmitterLayer * caELayer                   = [CAEmitterLayer layer];
    // 发射源
    caELayer.emitterPosition   = CGPointMake(Windows_Width / 2,Windows_Height - 20);
    // 发射源尺寸大小
    caELayer.emitterSize       = CGSizeMake(0, 0);
    // 发射源模式
    caELayer.emitterMode       = kCAEmitterLayerOutline;
    // 发射源的形状
    caELayer.emitterShape      = kCAEmitterLayerLine;
    // 渲染模式
    caELayer.renderMode        = kCAEmitterLayerAdditive;
    // 发射方向
    //self.caELayer.velocity          = 1;
    // 随机产生粒子
    //self.caELayer.seed              = (arc4random() % 100) + 1;
    
    
    // cell
    CAEmitterCell *cell             = [CAEmitterCell emitterCell];
    // 速率
    cell.birthRate                  = 2;
    
    // 发射的角度
    cell.emissionRange              = M_PI /6;
    // 速度
    cell.velocity                   = 300;
    // 范围
    cell.velocityRange              = 150;
    // Y轴 加速度分量
    cell.yAcceleration              = 75;
    // 声明周期
    cell.lifetime                   = 2.04;
    //是个CGImageRef的对象,既粒子要展现的图片
    cell.contents                   = (id)
    [[UIImage imageNamed:@"FFTspark"] CGImage];
    // 缩放比例
    cell.scale                      = 0.05;
    // 粒子的颜色
    cell.color                      = [[UIColor colorWithRed:0.6
                                                       green:0.6
                                                        blue:0.6
                                                       alpha:1.0] CGColor];
    // 一个粒子的颜色green 能改变的范围
    cell.greenRange                 = 1.0;
    // 一个粒子的颜色red 能改变的范围
    cell.redRange                   = 1.0;
    // 一个粒子的颜色blue 能改变的范围
    cell.blueRange                  = 1.0;
    // 子旋转角度范围
    cell.spinRange                  = M_PI;
    
    
    // 爆炸
    CAEmitterCell *burst            = [CAEmitterCell emitterCell];
    // 粒子产生系数
    burst.birthRate                 = 1.0;
    // 速度
    burst.velocity                  = 0;
    // 缩放比例
    burst.scale                     = 1.5;
    // shifting粒子red在生命周期内的改变速度
    burst.redSpeed                  = -1.5;
    // shifting粒子blue在生命周期内的改变速度
    burst.blueSpeed                 = +1.5;
    // shifting粒子green在生命周期内的改变速度
    burst.greenSpeed                = +1.0;
    //生命周期
    burst.lifetime                  = 0.35;
    
    
    // 火花 and finally, the sparks
    CAEmitterCell *spark            = [CAEmitterCell emitterCell];
    //粒子产生系数，默认为1.0
    spark.birthRate                 = 400;
    //速度
    spark.velocity                  = 68;
    // 360 deg//周围发射角度
    spark.emissionRange             = M_PI;
    // gravity//y方向上的加速度分量
    //spark.yAcceleration             = 37;
    //粒子生命周期
    spark.lifetime                  = 1.5;
    //是个CGImageRef的对象,既粒子要展现的图片
    spark.contents                  = (id)
    [[UIImage imageNamed:@"FFTspark"] CGImage];
    //缩放比例速度
    
    spark.scaleSpeed                = -0.01;
    //粒子green在生命周期内的改变速度
    spark.greenSpeed                = -0.05;
    //粒子red在生命周期内的改变速度
    spark.redSpeed                  = 0.2;
    //粒子blue在生命周期内的改变速度
    spark.blueSpeed                 = -0.05;
    //粒子透明度在生命周期内的改变速度
    spark.alphaSpeed                = -0.18;
    //子旋转角度
    spark.spin                      = 2* M_PI;
    //子旋转角度范围
    spark.spinRange                 = 2* M_PI;
    
    
    caELayer.emitterCells = @[cell];
    
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.layer addSublayer:caELayer];
    
}
@end
