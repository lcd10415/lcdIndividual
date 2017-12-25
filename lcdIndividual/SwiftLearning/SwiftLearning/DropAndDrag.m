//
//  DropAndDrag.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/21.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "DropAndDrag.h"
#import <UIKit/UIKit.h>
// iOS高级拖放
@interface DropAndDrag()<UIDragInteractionDelegate,UIDropInteractionDelegate>
@property(nonatomic,assign)id<NSItemProviderWriting>  imageModel;

@end

@implementation DropAndDrag
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup{
    UIDragInteraction * dragInteration = [[UIDragInteraction alloc] initWithDelegate:self];
    UIViewController * vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    [vc.view addSubview:dragInteration];
}

-(NSArray<UIDragItem *> *)dragInteraction:(UIDragInteraction *)interaction itemsForBeginningSession:(id<UIDragSession>)session{
    if (!self.imageModel) {
        return @[];
    }
    NSItemProvider * itemProvider = [[NSItemProvider alloc] initWithObject:self.imageModel];
    UIDragItem * dragItem = [[UIDragItem alloc]initWithItemProvider:itemProvider];
    return @[dragItem];
    
}

@end
