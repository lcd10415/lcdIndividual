//
//  Stars.m
//  生日烟火
//
//  Created by rexsu on 2017/2/24.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "Stars.h"
#import "UIView+Extension.h"
#define Windows_Width [UIScreen mainScreen].bounds.size.width
#define Windows_Height [UIScreen mainScreen].bounds.size.height


@interface Stars ()
{
    CABasicAnimation *rotation;
    UIBezierPath *_path;
    ActionFire _actionFire;
    ActionBoom _actionBoom;
}
//旋转
@property (nonatomic,strong)CAEmitterLayer * subLayer;
//运动时尾部流星
@property (nonatomic,strong)CAEmitterLayer * shootingStar;

@property (nonatomic,strong)CAEmitterLayer * boomLayer;
@end

@implementation Stars


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"1_star_2@3x"];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.image = [UIImage imageNamed:@"1_star_2@3x"];
    }
    return self;
}

- (void)animationMove
{
    
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path                  = [self getAnimationPath].CGPath;
    animation.duration              = 1;
    animation.repeatCount           = 1;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    [self.layer addAnimation:animation forKey:nil];
    
    if (!rotation) {
        rotation                    = [CABasicAnimation animation];
        rotation.keyPath            = @"transform.rotation";
        //2秒内逆时针旋转3周
        rotation.toValue            = @(- M_PI * 2);
        rotation.duration           = 1;
        [self.layer addAnimation:rotation forKey:nil];
        [self performSelector:@selector(animation2) withObject:nil afterDelay:1];
    }
}

-(void)animation2{
    
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path                  = [self getAnimationPath2].CGPath;
    animation.duration              = 0.8;
    animation.repeatCount           = 1;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    [self.layer addAnimation:animation forKey:nil];
    
    CABasicAnimation * rotation2 = [CABasicAnimation animation];
    rotation2.keyPath            = @"transform.rotation";
    //2秒内逆时针旋转3周
    rotation2.toValue            = @(- M_PI * 6/5 );
    rotation2.duration           = 0.8;
    [self.layer addAnimation:rotation2 forKey:nil];
    [self performSelector:@selector(rotateScattering) withObject:nil afterDelay:3];
}

-(void)rotateScattering{
    _actionBoom();
    [self addShootingStarLayer];
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path                  = [self getAnimationPath3].CGPath;
    animation.duration              = 4;
    animation.repeatCount           = 1;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    [self.layer addAnimation:animation forKey:nil];
    [self performSelector:@selector(zhongxinxuanzhuan) withObject:nil afterDelay:0];
}

-(UIBezierPath *)getAnimationPath{
    // 初始化UIBezierPath
    UIBezierPath * path             = [UIBezierPath bezierPath];
    
    ///////
    //----设置第一段路径
    //////
    // 首先设置一个起始点
    CGPoint startPoint              = CGPointMake(Windows_Width - self.width/2 , Windows_Height- self.width/2);
    // 以起始点为路径的起点
    [path moveToPoint:startPoint];
    // 设置第一个控制点
    CGPoint controlPoint1           = CGPointMake(Windows_Width - self.width/2 , Windows_Height- self.width/2);
    // 设置第二个控制点
    CGPoint controlPoint2           = CGPointMake(Windows_Width * 5/6 , Windows_Height *7/8);
    // 设置第一个终点
    CGPoint endPoint                = CGPointMake(Windows_Width *2/3, Windows_Height - self.width/2);
    // 添加三次贝塞尔曲线
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    return path;
}
-(UIBezierPath *)getAnimationPath2{
    UIBezierPath * path             = [UIBezierPath bezierPath];
    CGPoint startPoint                = CGPointMake(Windows_Width *2/3, Windows_Height - self.width/2);
    // 设置另一个起始点
    [path moveToPoint:startPoint];
    // 设置第三个控制点
    CGPoint controlPoint3 = CGPointMake(Windows_Width *7/12 + 30, Windows_Height * 15/16);
    // 设置第四个控制点
    CGPoint controlPoint4 = CGPointMake(Windows_Width / 2 + 30, Windows_Height - self.width/2);
    [path addCurveToPoint:controlPoint4 controlPoint1:controlPoint3 controlPoint2:controlPoint4];
    
    ///////
    //----设置第三段路径
    //////
    CGPoint controlPoint5 = CGPointMake(Windows_Width/2, Windows_Height - self.width/2);
    [path addLineToPoint:controlPoint5];
    return path;
}
-(UIBezierPath *)getAnimationPath3{
    UIBezierPath * path             = [UIBezierPath bezierPath];
    CGPoint startPoint              = CGPointMake(Windows_Width/2, Windows_Height - self.width/2);
    // 设置第一个起始点
    [path moveToPoint:startPoint];
    // 设置第一个直线终点
    CGPoint endPoint                = CGPointMake(0, Windows_Height / 3 );
    [path addLineToPoint:endPoint];
    
    [path moveToPoint:endPoint];
    CGPoint endPoint2               = CGPointMake(Windows_Width, Windows_Height * 2/ 3 );
    [path addLineToPoint:endPoint2];
    
    [path moveToPoint:endPoint2];
    CGPoint endPoint3               = CGPointMake(0, 0);
    [path addLineToPoint:endPoint3];
    
    [path moveToPoint:endPoint3];
    CGPoint endPoint4               = CGPointMake(Windows_Width /2, Windows_Height /2);
    [path addLineToPoint:endPoint4];
    
    return path;
}
-(UIBezierPath *)getAnimationPath4{
    UIBezierPath * path             = [UIBezierPath bezierPath];
    ///////
    //----设置第一段路径
    //////
    // 首先设置一个起始点
    CGPoint startPoint              = CGPointMake(Windows_Width/2 , Windows_Height/2);
    // 以起始点为路径的起点
    [path moveToPoint:startPoint];
    
    CGPoint endPoint                = CGPointMake(Windows_Width / 2, 80);
    [path addLineToPoint:endPoint];
    
    return path;
}
//中心旋转
-(void)zhongxinxuanzhuan{
    CABasicAnimation * rotation2 = [CABasicAnimation animation];
    rotation2.keyPath            = @"transform.rotation";
    //2秒内逆时针旋转3周
    rotation2.toValue            = @(- M_PI * 4 );
    rotation2.duration           = 0.8;
    rotation2.repeatCount        = MAXFLOAT;
    [self.layer addAnimation:rotation2 forKey:nil];
    [self performSelector:@selector(addFire) withObject:nil afterDelay:4];
    [self performSelector:@selector(rotateScattering2) withObject:nil afterDelay:6];
}

-(void)rotateScattering2{
    
    CAKeyframeAnimation *animation  = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path                  = [self getAnimationPath4].CGPath;
    animation.duration              = 3;
    animation.repeatCount           = 1;
    animation.fillMode              = kCAFillModeForwards;
    animation.removedOnCompletion   = NO;
    [self.layer addAnimation:animation forKey:nil];
    
    CABasicAnimation * scale        = [CABasicAnimation animation];
    scale.duration                  = 3;
    scale.keyPath                   = @"transform.scale";
    scale.toValue                   = @(0);
    scale.fillMode                  = kCAFillModeForwards;
    scale.removedOnCompletion       = NO;
    [self.layer addAnimation:scale forKey:nil];
    [self performSelector:@selector(actionFire) withObject:nil afterDelay:4];
    [self performSelector:@selector(actionBoom) withObject:nil afterDelay:3];
}

-(void)actionFire{
    _actionFire();
}
-(void)actionBoom{
    _actionBoom();
}
-(void)actionFireWithBlock:(ActionFire)actionFire{
    _actionFire = actionFire;
}
-(void)actionBoomWithBlock:(ActionBoom)actionBoom{
    _actionBoom = actionBoom;
}
-(void)addFire{
    [self stopShootingStar];
    self.subLayer                               = [CAEmitterLayer layer];
    self.subLayer.position                      = CGPointMake(self.width/2, self.height/2);
    self.subLayer.emitterSize                   = CGSizeMake(self.width, self.width);
    self.subLayer.emitterMode                   = kCAEmitterLayerOutline;
    self.subLayer.emitterShape                  = kCAEmitterLayerCircle;
    self.subLayer.renderMode                    = kCAEmitterLayerOldestFirst;
    self.subLayer.zPosition                     = -15;
    self.subLayer.masksToBounds                 = NO;
    
    CAEmitterCell * fire                        = [CAEmitterCell emitterCell];
    fire.birthRate                              = 1800;
    fire.velocity                               = 70;
    fire.lifetime                               = 1;
    fire.contents                               = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    fire.color                                  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    fire.scale                                  = 0.1;
    fire.greenRange                             = 0.4;
    fire.redRange                               = 0.4;
    fire.blueRange                              = 0.4;
    fire.scaleSpeed                             = -0.1;
    fire.greenSpeed                             = -0.05;
    fire.redSpeed                               = 0.2;
    fire.blueSpeed                              = -0.05;
    
    fire.alphaSpeed                             = -0.18;
    fire.spin                                   = 2* M_PI;
    fire.spinRange                              = 2* M_PI;
    //发射角度（不可少的属性）
    fire.emissionRange                          = M_PI;
    
    
    self.subLayer.emitterCells                  = @[fire];
    [self.layer addSublayer:self.subLayer];
    
}

-(void)addShootingStarLayer{
    self.shootingStar                           = [CAEmitterLayer layer];

    self.shootingStar.position                      = CGPointMake(self.width/2, self.height/2);
    self.shootingStar.emitterSize                   = CGSizeMake(self.width, self.width);
    self.shootingStar.emitterMode                   = kCAEmitterLayerPoints;
    self.shootingStar.emitterShape                  = kCAEmitterLayerSurface;
    self.shootingStar.renderMode                    = kCAEmitterLayerAdditive;
    self.shootingStar.zPosition                     = -15;
    self.shootingStar.masksToBounds                 = NO;
    
    CAEmitterCell * fire                        = [CAEmitterCell emitterCell];
    fire.name                                   = @"fire";
    fire.birthRate                              = 800;
    fire.velocity                               = 170;
    fire.lifetime                               = 1;
    fire.contents                               = (id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    fire.color                                  = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    fire.scale                                  = 0.1;
    fire.greenRange                             = 0.4;
    fire.redRange                               = 0.4;
    fire.blueRange                              = 0.4;
    fire.scaleSpeed                             = -0.1;
    fire.greenSpeed                             = -0.05;
    fire.redSpeed                               = 0.2;
    fire.blueSpeed                              = -0.05;
    
    fire.alphaSpeed                             = -0.18;
    fire.spin                                   = 2* M_PI;
    fire.spinRange                              = 2* M_PI;
    //发射角度（不可少的属性）
    fire.emissionRange                          = M_PI;
    self.shootingStar.emitterCells                  = @[fire];
    [self.layer addSublayer:self.subLayer];
}

-(void)stopShootingStar{
    [self.shootingStar setValue:@(0) forKeyPath:@"emitterCells.fire.birthRate"];
}

@end
