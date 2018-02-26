//
//  MapView.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/10/23.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "MapView.h"
#define scnW [[UIScreen mainScreen] bounds].size.width

@implementation MapView

- (void)onFirstClick:(UIButton *)sender {
    self.scrollView.contentOffset = CGPointMake(0, 0);
}
- (void)onSecondClick:(UIButton *)sender {
    self.scrollView.contentOffset = CGPointMake(scnW, 0);
}
- (void)onThirdClick:(UIButton *)sender {
    self.scrollView.contentOffset = CGPointMake(2*scnW, 0);
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor grayColor];
    [self addSubview:self.btnFirst];
    [self addSubview:self.btnSecond];
    [self addSubview:self.btnThird];
    [self addSubview: self.scrollView];
    
    self.scrollView.contentSize = CGSizeMake(scnW, 150);
    [self.scrollView setScrollEnabled:YES];
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        // Fallback on earlier versions
    }
    CGFloat w =  CGRectGetWidth(self.scrollView.bounds);
    CGFloat h = CGRectGetHeight(self.scrollView.bounds);
   
    for (int i = 0; i < 3; i++) {
        UIView * imageV = [[UIView alloc] initWithFrame:CGRectMake(w*i,0 , w, h)];
        int random = arc4random()%255;
        imageV.backgroundColor = [UIColor colorWithRed:random/255.0 green:random/255.0 blue:random/255.0 alpha:1];
        imageV.userInteractionEnabled = YES;
        imageV.tag = 1000 + i;
        [self.scrollView addSubview:imageV];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.contentOffset.x == 0) {
        self.btnFirst.selected = YES;
    } else if (scrollView.contentOffset.x == scnW){
        self.btnSecond.selected = YES;
    }else{
        self.btnThird.selected = YES;
    }
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.center.x-150, scnW, 150)];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(scnW, 150);
        _scrollView.center = self.center;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}
-(UIButton *)btnSecond{
    if (!_btnSecond) {
        _btnSecond = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSecond.backgroundColor = [UIColor redColor];
        _btnSecond.center = CGPointMake(self.scrollView.center.x, self.scrollView.center.y - 150);
        [_btnSecond addTarget:self action:@selector(onSecondClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSecond;
}
-(UIButton *)btnFirst{
    if (!_btnFirst) {
        _btnFirst = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnFirst.backgroundColor = [UIColor blueColor];
        _btnFirst.center = CGPointMake(self.btnSecond.center.x - 150, self.btnSecond.center.y);
        [_btnFirst addTarget:self action:@selector(onFirstClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnFirst;
}
-(UIButton *)btnThird{
    if (!_btnThird) {
        _btnThird = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnThird.backgroundColor = [UIColor greenColor];
        _btnThird.center = CGPointMake(self.btnSecond.center.x + 150, self.btnSecond.center.y);
        [_btnThird addTarget:self action:@selector(onThirdClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnThird;
}





























@end
