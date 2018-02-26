//
//  UIApplication+CurrentVC.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/22.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "UIApplication+CurrentVC.h"
#import <objc/runtime.h>

@implementation UIApplication (CurrentVC)

-(UIViewController *)currentVC{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setCurrentVC:(UIViewController *)currentVC{
    objc_setAssociatedObject(self, @selector(currentVC), currentVC, OBJC_ASSOCIATION_ASSIGN);
}

@end
