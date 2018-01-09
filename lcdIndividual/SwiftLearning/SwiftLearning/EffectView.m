//
//  EffectView.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/1/9.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "EffectView.h"

@interface EffectView()
@property(nonatomic,strong)UIImageView * blurImageView;
@property(nonatomic,strong)UILabel     * backLab;
@end

@implementation EffectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:blur];
    visualEffect.frame = self.blurImageView.frame;
    visualEffect.alpha = 1;
    [self.blurImageView addSubview:visualEffect];
    [visualEffect.contentView addSubview:self.backLab];
}

-(UIImageView *)blurImageView{
    if (!_blurImageView) {
        _blurImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _blurImageView.image = [UIImage imageNamed:@""];
        _blurImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _blurImageView;
}

-(UILabel *)backLab{
    if (!_backLab) {
        _backLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 100, 20)];
        _backLab.text = @"this is a message";
        _backLab.textAlignment = NSTextAlignmentCenter;
    }
    return _backLab;
}




































@end
