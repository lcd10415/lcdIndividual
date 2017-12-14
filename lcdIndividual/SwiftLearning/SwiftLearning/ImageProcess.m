//
//  ImageProcess.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/24.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "ImageProcess.h"
#import <UIKit/UIKit.h>

@implementation ImageProcess

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self filterWithOriginalImage:[UIImage new] filterName:@"图片名"];
//        self.backgroundColor = [UIColor redColor];
        self.header = [[UIImageView alloc]init];
        self.header.frame = CGRectMake(0, 0, 100, 100);
        self.header.image = [UIImage imageNamed:@"8.png"];
        NSLog(@"%@---------%@",self.header,self.header.image);
        [self addSubview:self.header];
    }
    return self;
}

#pragma mark - 对图片进行滤镜处理
 // 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
 // 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
 // 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
 // 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome
 // CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField
- (UIImage *)filterWithOriginalImage:(UIImage *)image filterName:(NSString *)name{
    CIContext * context = [CIContext contextWithOptions:nil];
    CIImage * inputImage = [[CIImage alloc] initWithImage:image];
    CIFilter * filter = [CIFilter filterWithName:name];
    //设置滤镜
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage * resultImg = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImg;
}
- (void)setupRadiusImage:(NSInteger)num{
    switch (num) {
        case 0:
            [self setupImageLayer];
            break;
        case 1:
            [self drawCircleCorner];
            break;
        case 2:
            [self setupImageCorner];
            break;
            
        default:
            break;
    }
}
-(void)setupImageLayer{
    self.header.layer.cornerRadius = self.header.frame.size.width / 2;
    //将多余的部分切掉
    self.header.layer.masksToBounds = YES;
    [self addSubview:self.header];
}
-(void)drawCircleCorner{
    //开始对imageView进行画图
    UIGraphicsBeginImageContextWithOptions(self.header.bounds.size, NO, [UIScreen mainScreen].scale);
    //使用贝塞尔曲线画出一个圆形图
    [[UIBezierPath bezierPathWithRoundedRect:self.header.bounds cornerRadius:self.header.frame.size.width] addClip];
    [self.header drawRect:self.header.bounds];
    
    self.header.image = UIGraphicsGetImageFromCurrentImageContext();
    //结束画图
    UIGraphicsEndImageContext();
    [self addSubview:self.header];
}
-(void)setupImageCorner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.header.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.header.bounds.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.header.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.header.layer.mask = maskLayer;
    [self addSubview:self.header];
}


@end
