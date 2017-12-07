//
//  TransitionAnimation.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/19.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "TransitionAnimation.h"

@implementation TransitionAnimation
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.8f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController * vc = [transitionContext viewControllerForKey:UITransitionContextFromViewKey];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    //设置modal出界面view的frame
    CGRect finalF = [transitionContext finalFrameForViewController:vc];
    //设置目标界面frame的offset,即初始位置
    vc.view.frame = CGRectOffset(finalF, 0, bounds.size.height);
    
    //取出containerView，将目标vc进行添加
    UIView * containerView = [transitionContext containerView];
    [containerView addSubview:vc.view];
    //设置view的frame动画效果
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        vc.view.frame = finalF;
    } completion:^(BOOL finished) {
        //提交transion完成
        [transitionContext completeTransition:YES];
    }];
}

@end
