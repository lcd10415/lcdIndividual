//
//  AnimationViewController.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/30.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()
@property(nonatomic,strong)UITextField * nameText;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setKeyAnimation];
    [self setFly];
    [self addTransitionAnimation];
    // Do any additional setup after loading the view.
}
-(void)setBasicAnimation{
    CABasicAnimation * basic = [CABasicAnimation animation];
    basic.keyPath = @"position.x";
    basic.fromValue = @77;
    basic.toValue = @455;
    basic.duration = 1;
    
//    设置fillMode动画留在最终哪个状态  设置removedOnCompletion防止它被自动移除
    basic.fillMode = kCAFillModeForwards;
    basic.removedOnCompletion = NO;
}

//关键帧动画定义超过两个步骤
- (void)setKeyAnimation{
    //关键帧动画1.path(CGPathRef对象) 2.values
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform.roration.z"];
    ani.values = @[@(-M_PI_4 / 5),@(M_PI_4/5),@(-M_PI_4 / 5)];
    ani.repeatCount = CGFLOAT_MAX;
    [self.view.layer addAnimation:ani forKey:@"rotation"];
}

//输入密码错误，输入框抖动
- (void)setMyAnition{
    CAKeyframeAnimation * keyAni = [CAKeyframeAnimation animation];
    keyAni.keyPath = @"position.x";
    keyAni.values = @[@0,@10,@-10,@10,@0];
    keyAni.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];//指定关键帧动画发生的时间
    keyAni.duration = 0.4;
    keyAni.additive = YES;
    [self.nameText.layer addAnimation:keyAni forKey:@"shake"];
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
    transition.startProgress  = 0;
    transition.endProgress    = 1.0;
    transition.type     = kCATransitionFade;//
    transition.subtype  = kCATransitionFromRight;
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
    CABasicAnimation * basic  = [self createRotate:self.view.layer];
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



//QuartzCore.framework
/*
 Core Animation:Objective-C API做二维动画
 Core Image:图像和视频处理(滤镜，扭曲，转换)
 */

//Quartz 2D
/*
 CGPathRef：用于向量图，可创建路径，并进行填充或描画(stroke)
 CGImageRef：用于表示bitmap图像和基于采样数据的bitmap图像遮罩。
 CGLayerRef：用于表示可用于重复绘制(如背景)和幕后(offscreen)绘制的绘画层
 CGPatternRef：用于重绘图
 CGShadingRef、CGGradientRef：用于绘制渐变
 CGFunctionRef：用于定义回调函数，该函数包含一个随机的浮点值参数。当为阴影创建渐变时使用该类型
 CGColorRef, CGColorSpaceRef：用于告诉Quartz如何解释颜色
 CGImageSourceRef,CGImageDestinationRef：用于在Quartz中移入移出数据
 CGFontRef：用于绘制文本
 CGPDFDictionaryRef, CGPDFObjectRef, CGPDFPageRef, CGPDFStream, CGPDFStringRef, and CGPDFArrayRef：用于访问PDF的元数
 CGPDFScannerRef, CGPDFContentStreamRef：用于解析PDF元数据
 CGPSConverterRef：用于将PostScript转化成PDF。在iOS中不能使用
 */

//绘图创建步骤(重写drawRect函数) 图像的重绘（刷帧）
/*
 1、我们首先需要开启图形上下文`CGContextRef ctx = UIGraphicsGetCurrentContext();
 //为C语言，创建对象无需加*`。
 2、然后对我们想绘制的图片或者图形进行一系列的操作（添加路径，设置属性等）。
 3、最后就是渲染在我的View上面。
 
 调用重绘view对象的
 
 - (void)setNeedsDisplay; 刷新全部view
 - (void)setNeedsDisplayInRect:(CGRect)rect; 刷新区域为rect的view
 
 drawRect方法使用注意点
 在iOS开发中不允许开发者直接调用drawRect:方法，刷新绘制内容需要调用setNeedsDisplay方法。
 若使用CALayer绘图，只能在drawInContext: 中（类似于drawRect）绘制，或者在delegate中的相应方法绘制。同样也是调用setNeedDisplay等间接调用以上方法
 若要实时画图，不能使用gestureRecognizer，只能使用touchbegan等方法来调用setNeedsDisplay实时刷新屏幕
 凡是“UI”开头的相关绘图函数，都是UIKit对Core Graphics的封装
 
 画图实例
    1.设置线段的宽度 CGContextSetLineWidth
    2.设置线段颜色   CGContextSetRGBStrokeColor
    3.设置起点和终点(圆角 直角) CGContextSetlineCap
    4.设置连接点样式(圆角 尖角) CGContextSetLineJoin
    5.设置竖线       CGContextSetLineDash
    6.填充颜色(实心)  CGContextSetRGBFillColor [UIColor redColor] setFill]

 主要渲染填充模式CGPathDrawingMode
        kCGPathStroke:画线（空心），只有边框
        kCGPathFill:  填充（实心），只有填充（非零缠绕数填充），不绘制边框
        kCGPathEOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
        kCGPathFillStroke：既有边框又有填充
        kCGPathEOFillStroke：奇偶填充并绘制边框
 
 渲染方式写法
        1. CGContextDrawPath(context, kCGPathStroke);
        2. CGContextStrokePath(ctx);
 
 主要画图Api
        1.直线 CGContextAddLineToPoint
        2.椭圆 CGContextAddEllipseInRect
        3.矩形 CGContextAddRect
        4.圆   CGContextAddArc
 
 */
- (void)drawRect1:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 50, 50);
    CGContextMoveToPoint(ctx, 100, 100);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    free(ctx);
}

- (void)drawRect2:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //获取路径
//    CGMutablePathRef path1 = CGPathCreateMutable();
//    CGPathMoveToPoint(path1, NULL, 50, 50);
//    CGPathMoveToPoint(path1, NULL, 100, 100);
//    将路径添加到上下文中
//    CGContextAddPath(ctx, path1);
    CGContextStrokePath(ctx);
//    free(path1);
    free(ctx);
}
- (void)drawRect3:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIBezierPath * path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(100, 100)];
    
    //将路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
    free(ctx);
}
//C(CGPath)+OC(UIBezierPath)
- (void)drawRect4:(CGRect)rect{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 50, 50);
    CGPathMoveToPoint(path, NULL, 100, 100);
    
    UIBezierPath * bPath = [UIBezierPath bezierPathWithCGPath:path];
    [bPath addLineToPoint:CGPointMake(60, 60)];
    CGContextAddPath(ctx, bPath.CGPath);
    free(ctx);
    free(path);
}

//OC实现(UIBezierPath)
- (void)drawRect5:(CGRect)rect{
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(50, 50)];
    [path stroke];
}
//直线 CGContextMoveToPoint(ctx,0,40);
//TODO: 画直线
-(void)drawLine
{
    //获得当前画板（图形上下文对象）为C语言，创建对象无需加*
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //!!!: 相关属性设置 可选
    //设置线条的颜色
    //CGContextSetRGBStrokeColor(ctx, 0.2, 0.2, 0.2, 1.0);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetLineWidth(ctx, 10); // 设置线段的宽度
    CGContextSetLineJoin(ctx, kCGLineJoinRound); // 设置线段起点和终点的样式都为圆角
    CGContextSetLineCap(ctx, kCGLineCapRound);   // 设置线段的转角样式为圆角
    
    //开始画线, x，y为开始点的坐标
    CGContextMoveToPoint(ctx, 0, 40);
    //画直线, x，y为线条结束点的坐标
//    CGContextAddLineToPoint(ctx, self.bounds.size.width,40);
    CGContextStrokePath(ctx);//渲染，绘制出一条空心的线段
}

//TODO: 三角形
- (void)drawTriangle
{
    CGContextRef triangle = UIGraphicsGetCurrentContext(); // 获得图形上下文
    CGContextMoveToPoint(triangle, 150, 40); // 设置起点
    CGContextAddLineToPoint(triangle, 60, 200); // 设置第二个点
    CGContextAddLineToPoint(triangle,240, 200); // 设置第三个点
    CGContextClosePath(triangle); // 关闭起点和终点
    CGContextStrokePath(triangle); // 渲染，绘制出三角形
}
//TODO: 矩形
-(void)drawaRect
{
    //获得当前画板
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //颜色
    CGContextSetRGBStrokeColor(ctx, 0.2, 0.2, 0.2, 1.0);
    //画线的宽度
    CGContextSetLineWidth(ctx, 0.25);
    CGContextAddRect(ctx, CGRectMake(2, 2, 30, 30));
    CGContextStrokePath(ctx);
}


/**
 *  画圆
 *  @param ctx        上下文
 *  @param x          圆起点坐标X
 *  @param y          圆起点坐标y
 *  @param radius     圆的半径
 *  @param startAngle 起始角度
 *  @param endAngle   结束角度
 *  @param clockwise  顺逆时针
 */
//CGContextAddArc(CGContextRef ctx, CGFloat x, CGFloat y,CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)

//TODO: 画圆
- (void)drawRoundRect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(ctx, 0.2, 0.2, 0.2, 1.0);//颜色
    CGContextSetLineWidth(ctx, 0.25);//画线的宽度
    
//    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);//设置圆心位置
//    CGFloat radius = self.bounds.size.height / 2;//设置半径
//    CGFloat startAngle = - M_PI_2;//圆起点位置
//    CGFloat endAngle = - M_PI_2 +  M_PI * 2;//圆终点位置
//    CGContextAddArc(ctx,center.x,center.y,radius,startAngle, endAngle, 0);
    
//    CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
}
//TODO: 环形
-(void)drawAnnular
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);//设置圆心位置
//    CGFloat radius = self.bounds.size.height / 2;//设置半径
    CGFloat startAngle = - M_PI_2;//圆起点位置
    CGFloat endAngle = - M_PI_2 +  M_PI * 2;//圆终点位置
//    CGContextAddArc(ctx,center.x,center.y,radius-5,startAngle, endAngle, 0);
    CGContextSetLineWidth(ctx, 10);
    [[UIColor greenColor]set];
    CGContextDrawPath(ctx, kCGPathStroke); //绘制路径
}
//绘制圆弧 就是一个圆形的一部分
-(void)circularArc
{
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);//设置圆心位置
//    CGFloat radius = self.bounds.size.height / 2;//设置半径
    CGFloat startAngle = - M_PI_2;//圆起点位置
    CGFloat endAngle = - M_PI_2 +  M_PI*1.2;//圆终点位置
//    CGContextAddArc(context, center.x,center.y,radius,startAngle, endAngle, 1);
    
    //绘制圆弧
    CGContextDrawPath(context, kCGPathStroke);
}

//椭圆
- (void)drawRect:(CGRect)rect
{
    CGContextRef circular = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(circular, CGRectMake(100, 100, 100, 80));//宽高相等=圆，宽高不等=椭圆
    CGContextSetRGBFillColor(circular, 1.0, 0, 1.0, 1);// 设置颜色
    CGContextFillPath(circular); // 渲染，将实心圆形画出
}

//扇形
-(void)drawPie
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);//设置圆心位置
//    CGFloat radius = self.bounds.size.height / 2;//设置半径
    CGFloat startAngle = - M_PI_2;//圆起点位置
    CGFloat endAngle = - M_PI_2 +  M_PI * 1.5;//圆终点位置
    [[UIColor greenColor]set];
    
    //顺时针画扇形
//    CGContextMoveToPoint(ctx, center.x, center.y);
//    CGContextAddArc(ctx, center.x, center.y, radius, startAngle,endAngle, 0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}
//绘制文本内容
//绘图只能在当前位方法中调用,否则无法得到图形上下文
- (void)drawRect7:(CGRect)rect{
    //要显示的文字
    NSString *str = @"这是要现实的文本Text。。。。";
    //绘制文字显示的指定区域
    CGRect rect1 = CGRectMake(20, 50, 374, 500);
    //字体大小
    UIFont *font = [UIFont systemFontOfSize:25];
    //字体颜色
    UIColor *color = [UIColor redColor];
    //初始化段落样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    //居中对齐
    NSTextAlignment textAlignment = NSTextAlignmentCenter;
    //设置段落样式
    paragraphStyle.alignment = textAlignment;
//    NSDictionary *attributes= @{NSFontAttributeName:font,NSForegroundColorAttributeName:color,
//                                NSParagraphStyleAttributeName:style};
//    [str drawInRect:rect withAttributes:attributes];
}

//绘制图片&&图片剪切CGContextClip
- (void)drawImage{
    UIImage *image = [UIImage imageNamed:@"theImage.jpg"];
    //从某一点开始绘制
    [image drawAtPoint:CGPointMake(10, 50)];
    //绘制到指定的矩形中，注意如果大小不合适会会进行拉伸，图像会形变
    [image drawInRect:CGRectMake(10, 50, 300, 450)];
    //平铺绘制
    //    [image drawAsPatternInRect:CGRectMake(0, 0, 320, 568)];
}
//绘图只能在当前位方法中调用,否则无法得到图形上下文
- (void)drawRect8:(CGRect)rect{
    //获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定上下文显示的范围
    CGContextAddEllipseInRect(context, CGRectMake(80, 50, 100, 100));
    //裁剪
    CGContextClip(context);
    //获取图片
    UIImage *image = [UIImage imageNamed:@"mv2.jpg"];
    [image drawAtPoint:CGPointMake(50, 50)];
}

//截屏
-(void)cutScreen{
    /*
     1、获得一个图片的画布
     2、获得画布的上下文
     3、设置截图的参数
     4、截图
     5、关闭图片的上下文
     6、保存
     */
    //1、获得一个图片的画布
//    UIGraphicsBeginImageContext(self.frame.size);
    //2、获得一个上下文
//    [self addRound];
    //3、设置参数
    /*
     CGSize size:截图尺寸
     BOOL opaque：是否不透明,YES不透明
     CGFloat scale：比例
     */
//    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, 1);
    //4、开始截图
//    UIImage image = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭图片上下文
    UIGraphicsEndImageContext();
    //保存到相册
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}
//保存到相册时的回调方法
//- (void)image:(UIImage* )image didFinishSavingWithError:(NSError *)error
//  contextInfo:(void )contextInfo{
//
//}






































































@end






























