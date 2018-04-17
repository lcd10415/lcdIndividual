//
//  HYPWheelView.m
//  彩票
//
//  Created by huangyipeng on 14-8-17.
//  Copyright (c) 2014年 HYP. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "HYPWheelView.h"
#import "WebVC.h"

@interface HYPWheelView ()

@property (weak, nonatomic) IBOutlet UIButton *centerBtn;
@property (nonatomic, weak) UIButton *lastClickBtn;
@property (nonatomic, strong) CADisplayLink *display;
@property (weak, nonatomic) IBOutlet UIView *centerView;
// 按钮初始化时的角度
@property (nonatomic, assign) CGFloat angle;

@end


@implementation HYPWheelView

- (void)awakeFromNib
{
    [self addBtns];
    self.angle = 0;
}

+ (instancetype)wheelView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LuckyWheel" owner:nil options:nil] lastObject];
}

- (void)addBtns
{
    UIImage *bgImg = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *selImg = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    int count = 12;
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnW = 65;
        CGFloat btnH = 134;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        btn.layer.position = self.centerView.center;
        CGFloat angle = i * (M_PI * 2 / count);
        btn.transform = CGAffineTransformMakeRotation(angle);
        [self.centerView addSubview:btn];
        
        // 计算裁剪的尺寸
        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat imgY = 0;
        CGFloat imgW = (bgImg.size.width / 12) * scale;
        CGFloat imgX = i * imgW;
        CGFloat imgH = bgImg.size.height * scale;
        CGRect imgRect = CGRectMake(imgX, imgY, imgW, imgH);
        
        // 裁剪图片
        CGImageRef cgImg = CGImageCreateWithImageInRect(bgImg.CGImage, imgRect);
        [btn setImage:[UIImage imageWithCGImage:cgImg] forState:UIControlStateNormal];
        
        CGImageRef selCgImg = CGImageCreateWithImageInRect(selImg.CGImage, imgRect);
        [btn setImage:[UIImage imageWithCGImage:selCgImg] forState:UIControlStateSelected];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        btn.contentEdgeInsets = UIEdgeInsetsMake(20, 15, 75, 17);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = i;
        if (i == 0) {
            [self btnClick:btn];
        }
    }
    
}

- (void)btnClick:(UIButton *)sender
{
    self.lastClickBtn.selected = NO;
    sender.selected = YES;
    // 每次点击一个按钮，都减去一个按钮的角度值
    self.angle -= sender.tag * M_PI / 6;
    self.lastClickBtn = sender;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self bringSubviewToFront:self.centerBtn];
}

- (void)addDisplayLink
{
    [self.display invalidate];
    self.display = nil;
    self.userInteractionEnabled = YES;
    // 添加定时刷新
    if (self.display == nil) {
        CADisplayLink *display = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeTransform)];
        self.display = display;
        [display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

- (void)changeTransform
{
    self.centerView.transform = CGAffineTransformRotate(self.centerView.transform, M_PI / 900);
    self.angle += M_PI / 900;
    // 转一圈以后，将角度重新置为0
    if (self.angle >= M_PI * 2) {
        self.angle = 0;
    }
}

- (void)start
{
//    [self addDisplayLink];
}

- (void)stop
{
    [self.display invalidate];
    self.display = nil;
}


- (IBAction)startSelectNumber {
    [self stop];
    
    // 禁止交互
    self.userInteractionEnabled = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    // 计算核心动画旋转的角度
    animation.toValue = @(M_PI * 2 * 4 - self.lastClickBtn.tag * M_PI / 6);
    animation.duration = 2;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    
    [self.centerView.layer addAnimation:animation forKey:@"animation"];
//    UIViewController * rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    WebVC * vc = [[WebVC alloc] init];
//    vc.URL = @"http://www.0234aa.com/";
//    [rootVC presentViewController:vc animated:YES completion:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // 将view旋转到顶部
    self.centerView.transform = CGAffineTransformMakeRotation( -( self.lastClickBtn.tag * M_PI / 6));
    self.angle = -self.lastClickBtn.tag * M_PI / 6;
    // 移除核心动画
    [self.centerView.layer removeAnimationForKey:@"animation"];
    // 1秒后添加转动
    [self performSelector:@selector(addDisplayLink) withObject:nil afterDelay:1];
}



@end
