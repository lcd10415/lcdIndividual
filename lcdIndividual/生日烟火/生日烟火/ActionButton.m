//
//  ActionButton.m
//  生日烟火
//
//  Created by rexsu on 2017/2/24.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "ActionButton.h"

@interface ActionButton()
//星星
@property (nonatomic,strong)UIImageView * star;
@end
@implementation ActionButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self actionAnimation];
}

-(void)actionAnimation{
    CAKeyframeAnimation * animation = [self changeSize];
    [self.layer addAnimation:animation forKey:@"transform.scale"];
    [self performSelector:@selector(SelfDisappear) withObject:nil afterDelay:1];
}
-(void)SelfDisappear{
    CABasicAnimation * animation = [self disappear];
    [self.layer addAnimation:animation forKey:@"transform.scale.y"];
    [self performSelector:@selector(SelfDisappear2) withObject:nil afterDelay:0.2];
}
-(void)SelfDisappear2{
    CABasicAnimation * animation = [self disappear2];
    [self.layer addAnimation:animation forKey:@"transform.scale.x"];

}
//关键帧动画，放大缩小
-(CAKeyframeAnimation *)changeSize{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1,@1.2,@1,@1.2,@1];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

//消失
-(CABasicAnimation *)disappear{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale.y";
    animation.duration = 0.2;
    animation.toValue = @0.02;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

-(CABasicAnimation *)disappear2{
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.scale.x";
    animation.duration = 0.1;
    animation.toValue = @0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}









@end
