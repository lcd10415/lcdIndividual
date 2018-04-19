//
//  MasonryUsage.m
//  MasonryUsage
//
//  Created by 178 on 2018/4/19.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "MasonryUsage.h"
#import "Masonry.h"
#import <UIKit/UIKit.h>
#import "MasonryCell.h"
/*
 Masonry是基于NSLayoutConstraint进行封装的第三方框架
 坑集：1.在使用masonry添加约束之前，需要在addSubview之后才能使用，否则会导致崩溃.
      2.约束冲突和缺少约束，测试可以用调试和log排查
 基本API:
    1.mas_makeConstraints() 添加约束
    2.mas_remakeConstraints() 移除之前的约束，重新添加新的约束
    3.mas_updateConstraints() 更新约束，
    4.equalTo()      参数是对象类型，一般是视图对象或者mas_width这样的坐标系对象
    5.mas_equalTo()  和上面功能相同，参数可以传递基础数据类型对象，可以理解为比上面的API更加强大
 */

@interface MasonryUsage()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UIView * centerView;

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,copy)NSArray * dataList;
@end

@implementation MasonryUsage

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    self.dataList = @[@"2",@"3",@"1",@"21",@"44",@"55",@"23"];
    //1.设置内间距
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.right.equalTo(self).with.offset(-10);
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        //mas_equalTo能设置基本数据类型
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
        //2.设置约束优先级 priorityLow()、priorityMedium()、priorityHigh(),
        make.height.equalTo(self).priority(200);
        //3.设置约束值乘以多少，例如centerView的宽度是self的宽度的0.2倍
        make.width.equalTo(self).multipliedBy(0.2);
    }];

    
}
- (void)tableViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"MasonryCell";
    MasonryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MasonryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        //设置tableView自动高度
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[MasonryCell class] forCellReuseIdentifier:@"MasonryCell"];
        [self addSubview:_tableView];
    }
    return _tableView;
}
@end












































