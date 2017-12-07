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
        [self filterWithOriginalImage:[UIImage new] filterName:@"图片名"];
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

@end
