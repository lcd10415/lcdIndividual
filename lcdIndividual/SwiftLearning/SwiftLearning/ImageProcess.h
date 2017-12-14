//
//  ImageProcess.h
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/24.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageProcess : UIView

@property(nonatomic,strong)UIImageView * header;

- (void)setupRadiusImage:(NSInteger)num;
@end
