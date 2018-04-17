//
//  WPDrowAnimationLayer.h
//  逐字展现文字
//
//  Created by rexsu on 2017/3/6.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPDrowAnimationLayer : CALayer
/**
 *  字符串画线
 *
 *  @param string    要画的字符串
 *  @param rect      位置
 *  @param view      父视图
 *  @param font      动画字体
 *  @param duration  动画时间
 */
+(void)createAnimationLayerWithString:(NSString*)string rect:(CGRect)rect view:(UIView*)view font:(UIFont*)font duretion:(NSInteger)duration;
@end
