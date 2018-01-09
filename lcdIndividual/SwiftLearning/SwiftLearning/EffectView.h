//
//  EffectView.h
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EffectView : UIVisualEffectView

- (instancetype)initWithEffect:(UIVisualEffect *)effect; //创建一个UIVisualEffectView类的类方法
+ (UIBlurEffect*)effectWithStyle:(UIBlurEffectStyle)style; //创建一个UIblurEffect实例方法
+ (UIVibrancyEffect*)effectForBlurEffect:(UIBlurEffect*)blurEffect;
@end
