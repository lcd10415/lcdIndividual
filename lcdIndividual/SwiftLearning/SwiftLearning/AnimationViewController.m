//
//  AnimationViewController.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/30.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setKeyAnimation];
    [self setFly];
    [self addTransitionAnimation];
    // Do any additional setup after loading the view.
}

- (void)setKeyAnimation{
    //关键帧动画1.path(CGPathRef对象) 2.values
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform.roration.z"];
    ani.values = @[@(-M_PI_4 / 5),@(M_PI_4/5),@(-M_PI_4 / 5)];
    ani.repeatCount = CGFLOAT_MAX;
    [self.view.layer addAnimation:ani forKey:@"rotation"];
}

- (void)setFly{
    CAKeyframeAnimation * keyAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *bPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 500)];
    keyAni.path = bPath.CGPath;
    keyAni.duration = 2;
    keyAni.repeatCount = CGFLOAT_MAX;
    //设置动画的计算模式
    keyAni.calculationMode = kCAAnimationPaced;
    [self.view.layer addAnimation:keyAni forKey:nil];
}

//转场动画CATransition KCATransitionFade 淡出效果  kCATransitionMoveIn 移入  kCATransitionPush 平移  kCATransitionReveal显露
//KCATransitionMoveIn 移动到旧视图
-(void)addTransitionAnimation{
    CATransition * transition = [CATransition animation];
    transition.startProgress = 0;
    transition.endProgress = 1.0;
    transition.type = kCATransitionFade;//
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.0;

    [self.view.layer addAnimation:transition forKey:@"transition"];
}

//动画组
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint p = [[touches anyObject] locationInView:self.view];
    CALayer * layer = self.view.layer;
    
    //组动画
    CAAnimationGroup * group = [CAAnimationGroup animation];
    CAKeyframeAnimation * key = [self createKeyAnimation:self.view.layer];
    CABasicAnimation * basic = [self createRotate:self.view.layer];
    group.animations = @[key,basic];
    [layer addAnimation:group forKey:@"GROUP"];
    
    layer.position = CGPointMake(layer.position.x, layer.position.y + 20);
    
    //在控制器中添加图层到屏幕上，已定要调用setNeedDisplay方法
    //开始绘制图层
    [layer setNeedsDisplay];
}

-(CAKeyframeAnimation *)createKeyAnimation:(CALayer *)layer{
    CGFloat x = layer.position.x;
    CGFloat y = layer.position.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    //起点
    CGPathMoveToPoint(path, nil, x, y);
    //添加点
    CGPathAddCurveToPoint(path, nil, x + 200, y, x+200, y+100, x, y+100);
    
    CAKeyframeAnimation * keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path = path;
    keyAnimation.duration = 5;
    [layer addAnimation:keyAnimation forKey:@"KEYFRAME"];
    return keyAnimation;
}

-(CABasicAnimation *)createRotate:(CALayer *)layer{
    
    CABasicAnimation * rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotate.z"];
    rotate.toValue = [NSNumber numberWithFloat:M_PI_2*3];
    rotate.duration = 5.0;
    [layer addAnimation:rotate forKey:@"KCABasicAnimation_Rotation"];
    return rotate;
}

//CAShapeLayer
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重新绘图
- (void)drawInContext:(CGContextRef)ctx {
    //绘制一个三角形
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    CGContextMoveToPoint(ctx, 50, 0);
//    从(50,0)连线到（0,100）
    CGContextAddLineToPoint(ctx, 0, 100);
    CGContextAddLineToPoint(ctx, 100, 100);
    CGContextClosePath(ctx);
    
    //绘制路径
    CGContextFillPath(ctx);
}

//绘制三个圆角一个直角的矩形
- (void)drawRectWithCorner{
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radi = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft;
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radi];
}

/*
 CALayer 基本属性
 
 opacity:      透明度
 shadowColor:  阴影颜色
 shadowOpacity 阴影透明度，设置范围0~1
 shadowOffset: 阴影偏移量
 shadowRadius: 阴影模糊度
 cornerRadius: 圆角
 anchorPoint:  位置的锚点
 masksToBounds 超出部分裁剪
 */


//UIImageView设置圆角  clipsToBounds 和  layer.cornerRadius
- (void)setImageRadius{
    UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imgV.center = CGPointMake(200, 300);
    UIImage * anoImg = [UIImage imageNamed:@""];
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imgV.bounds cornerRadius:50] addClip];
    [anoImg drawInRect:imgV.bounds];
    imgV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view addSubview:imgV];
}
//粒子动画CAEmitterLayer
/*
 emitterCells:NSArray<CAEmitterCell*>粒子单元组
 birthRate:float粒子创建速率
 lifetime:float粒子存活时间系数，默认为1s Animatable
 emitterSize发射器的 emitterDepth发射器的深度
 emitterShape发射器的形状(包括point默认的，line，rectangle矩形,circle圆形,cuboid立方体,sphere球形)
 emitterMode发射模式(points发射器内部发射，outline发射器边缘发出,surface发射器表面发出，volume发射器中点发出(默认的))
 renderMode渲染模式(unordered粒子无序(默认的),oldestFirst越早声明的粒子渲染层数越高,oldestLast越晚声明的粒子渲染层数越高,backToFront按照z轴的顺序渲染，additive粒子混合)
 preservesDepth:BOOL 开启深度显示(三维空间效果)
 velocity:float粒子速度系数默认为1 Animatable
 scale:float粒子缩放系数 默认为1 Animatable
 spin粒子旋转位置系数
 seed初始化随机的例子种子 默认为0
 
 
 CAEmitterCell
+(instancetype)emitterCell 构建方法
 name 发射单元名称，用于构建keyPath
 enabled:能否允许被渲染
 birthRate:每秒创建的粒子数，默认值0
 emissionLatitude:发射纬度：z轴方向的发射角度
 emissionLongitude:x-y平面中，相对于x轴的发射角度
 emissionRange:发射角度的容差CGFloat
 velocity:粒子平均速度及容差，默认值0
 */

//CAGradientLayer:梯度动画 系统提供的颜色梯度变化能力的类。
/*
 colors:CGColorRef颜色数组
 locations:NSArray<NSNumber*> 控制颜色范围的数组[0,1]类比KeyFrameAnimation中的keyTimes
 startPoint: 类似anchorPoint 是相对于视图本身映射关系的相对位置，要来绝对梯度变化的方向
 endPoint
 */

//CAShapeLayer














































@end






























