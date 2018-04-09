//
//  SCrollView.m
//  Experiment
//
//  Created by Liuchaodong on 2018/3/26.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "SCrollView.h"

//扩展
@interface SCrollView()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSArray * childVCs;
@end

@implementation SCrollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setData];
        [self setup];
    
    }
    return self;
}
- (void)setData{
    
}
- (void)setup{
    self.scrollView.contentOffset = self.scrollPro.contentOffset;
    self.scrollView.contentSize   = self.scrollPro.contentSize;
    
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        CGFloat width = SC_W;
        _scrollView.contentSize = CGSizeMake(width, 0);
    }
    return _scrollView;
}

@end
