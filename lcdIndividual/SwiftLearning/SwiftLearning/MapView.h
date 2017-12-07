//
//  MapView.h
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/23.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapView : UIView<UIScrollViewDelegate>
@property (strong, nonatomic)  UIButton * btnFirst;
@property (strong, nonatomic)  UIButton * btnSecond;
@property (strong, nonatomic)  UIButton * btnThird;
@property (strong, nonatomic)  UIScrollView * scrollView;

@end
