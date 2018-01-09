//
//  CustomView.m
//  CustomComponent
//
//  Created by ReleasePackageMachine on 2018/1/2.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
 UIKit是iOS系统使用的界面框架
 UIKit中最基本的类是UIView，也就是界面的基础操作类
 iOS使用的渲染框架叫Core Graphics，所以才回有CG开头的一堆基础类型，如CGFloat(浮点),CGPoint(点),CGSize(尺寸),CGRect(矩形)
 UIView对象都包含至少一个CALayer对象，CALayer才是最终渲染出效果的对象
 UIView和CALayer的层级关系是相同的，他们都是多叉树，同一个父View(superView)的子View们（subViews）是有层级覆盖关系的，上层的View遮挡下层View
 这里所说的层关系和设计软件中的层关系是类似的，如Photoshop，Sketch等
 UIView和CALayer的分工是，前者负责保存属性和处理响应链，后者负责渲染
 */


- (instancetype)initWithFrame: (CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


//如果需要对子视图重新布局，需要调用layoutSubviews方法
//layoutSubviews在以下情况下会被调用：
//1、init初始化不会触发layoutSubviews
//2、addSubview会触发layoutSubviews
//3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
//4、滚动一个UIScrollView会触发layoutSubviews
//5、旋转Screen会触发父UIView上的layoutSubviews事件
//6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
-(void)layoutSubviews{
    [super layoutSubviews];//注意一定不要忘记调用父类的layoutSubviews方法
}
//如果用xib创建自定义控件，通过loadNibNamed方法创建XIB对象
//UIView * view = [[[NSBundle mainBundle] loadNibNamed:@"Xib的名字" owner:nil options:nil] lastObject];

-(void)drawRect:(CGRect)rect{
    
}

-(void)configFotTitle:(NSArray<NSString *> *)titles{
    
    
}
@end
