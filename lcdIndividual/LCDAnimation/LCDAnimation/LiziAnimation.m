//
//  LiziAnimation.m
//  LCDAnimation
//
//  Created by ReleasePackageMachine on 2017/12/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "LiziAnimation.h"

@implementation LiziAnimation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//emitter的emitterShape属性:
//常用到的有三种:
//
//kCAEmitterLayerPoint 将所有的粒子集中在position的位置,可用来做火花爆炸效果
//kCAEmitterLayerLine 所有的粒子位于一条线上,可用来作瀑布效果,下雪效果
//kCAEmitterLayerRectangle 所有粒子随机出现在所给定的矩形框内

-(void)drawRect:(CGRect)rect{
//    CAEmitterLayer * layer = [CAEmitterLayer layer];
//    CGRect rect1 = CGRectMake(0, 0,self.bounds.size.width, 150);
//    layer.backgroundColor = [UIColor blackColor].CGColor;
//    layer.frame = rect1;
//    [self.layer addSublayer:layer];
//    
//    layer.emitterShape = kCAEmitterLayerRectangle;
//    layer.emitterPosition = CGPointMake(rect1.size.width/2, rect1.size.height/2);
//    layer.emitterSize = rect1.size;
//    
//    CAEmitterCell * cell = [CAEmitterCell emitterCell];
//    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"20"].CGImage);
//    cell.birthRate = 5;
//    cell.yAcceleration = 100;
//    cell.xAcceleration = 100;
//    cell.velocity = 20.0;
//    cell.emissionLatitude = M_PI_2;
//    cell.lifetime = 3;
//    layer.emitterCells = @[cell];
    
    [self showSnowEffect];
}

//contents：粒子的内容
//lifetime：存活的时间
//lifetimeRange：存活时间的范围
//birthRate：每秒粒子生成的数量
//emissionLatitude：散发的纬度（方向：上下）->弧度
//emissionLongitude：散发的经度（方向：左右）->弧度
//emissionRange：散发的范围 -> 弧度
//velocity：发送的速度（速度越快，跑的越远）
//velocityRange：发送速度的范围
//xAcceleration：X轴的加速度
//yAcceleration：Y轴的加速度
//zAcceleration：Z轴的加速度
//name：粒子的名字。可以通过名字，找到粒子
-(void)showSnowEffect{
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 500);
    layer.backgroundColor = [UIColor blackColor].CGColor;
    layer.frame = rect;
    [self.layer addSublayer:layer];
    
    layer.emitterShape = kCAEmitterLayerSphere;
    layer.emitterMode = kCAEmitterLayerSurface;
    layer.emitterPosition = CGPointMake(100, rect.size.height/4);
    layer.emitterSize = rect.size;
    
    CAEmitterCell * cell = [CAEmitterCell emitterCell];
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"8"].CGImage);
    cell.birthRate = 20;
//    emitterLayer可以添加很多不同类型的cell
    layer.emitterCells = @[cell];
    //x轴的加速度
    cell.xAcceleration = 70.0;
//    y轴的加速度
    cell.yAcceleration = 70.0;
    //设置微粒的一个发射速度
    cell.emissionLongitude = M_PI_2;
    //添加随机的速度
    cell.velocityRange = 200;
    cell.emissionLatitude = M_PI_2;
    cell.emissionRange = M_PI;
    cell.lifetimeRange = 20;
    
    cell.redRange = 0.5;
    cell.greenRange = 0.5;
    cell.blueRange = 0.5;
    
    cell.scaleRange = 0.8;
    cell.scaleSpeed = -0.15;
    
    cell.alphaRange = 0.75;
    cell.alphaSpeed = -0.15;
}













































@end



