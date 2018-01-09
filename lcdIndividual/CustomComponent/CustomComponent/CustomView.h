//
//  CustomView.h
//  CustomComponent
//
//  Created by ReleasePackageMachine on 2018/1/2.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomView : UIView
@property(nonatomic,assign)NSInteger titles;//记录titles的个数
- (void)configFotTitle:(NSArray<NSString*>*)titles;
@end
