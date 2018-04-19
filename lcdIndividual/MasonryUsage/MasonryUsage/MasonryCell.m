//
//  MasonryCell.m
//  MasonryUsage
//
//  Created by 178 on 2018/4/19.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "MasonryCell.h"
#import "Masonry.h"

@interface MasonryCell()
@property (nonatomic,strong)UIImageView * backImgView;
@property (nonatomic,strong)UILabel     * detailLab;
@end

@implementation MasonryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    [self.backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.left.bottom.right.equalTo(self.contentView).mas_offset(12);
    }];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImgView.mas_right).mas_offset(10);
        make.top.equalTo(self.contentView).mas_offset(10);
        make.right.bottom.equalTo(self.contentView).mas_offset(-10);
        make.height.greaterThanOrEqualTo(@20);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
