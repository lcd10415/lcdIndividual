//
//  UIViewController+Extension.m
//  生日烟火
//
//  Created by ReleasePackageMachine on 2017/11/7.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
+(instancetype)topMostViewController{
    
}

-(UIViewController*)topViewControllerForRoot:(UIViewController*)rootVC{
    UIViewController * presented = rootVC.presentedViewController;
    if (presented == nil) {
        return rootVC;
    }else{
        if (presented) {
            
        }
    }
}
@end
