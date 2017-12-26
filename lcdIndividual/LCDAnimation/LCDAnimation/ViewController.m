//
//  ViewController.m
//  LCDAnimation
//
//  Created by ReleasePackageMachine on 2017/12/26.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "ViewController.h"
#import "LCDAnimation.h"
#import "Gradient.h"
#import "BezierPath.h"
#import "LiziAnimation.h"
@interface ViewController ()
@property (nonatomic,strong)CALayer * myLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LiziAnimation * ani = [[LiziAnimation alloc] init];
    ani.frame = self.view.bounds;
    [self.view addSubview:ani];
    
    [self.view.layer addSublayer:self.myLayer];
    self.myLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"1024"].CGImage);
    NSLog(@"%@",[UIImage imageNamed:@"1024"]);
    self.myLayer.shadowColor = [UIColor grayColor].CGColor;
    self.myLayer.shadowOffset = CGSizeMake(50, 10);
    self.myLayer.shadowOpacity = 0.6;
    self.myLayer.cornerRadius = 100;
    self.myLayer.masksToBounds = YES;
    self.myLayer.borderColor = [UIColor brownColor].CGColor;
    self.myLayer.borderWidth = 5.0;
    // Do any additional setup after loading the view, typically from a nib.
}

-(CALayer *)myLayer{
    if (!_myLayer) {
        _myLayer = [CALayer layer];
        UIImage *img = [UIImage imageNamed:@"1024"];
        _myLayer.frame = CGRectMake(0, 468, 200, 200);
        _myLayer.backgroundColor = [UIColor greenColor].CGColor;
    }
    return _myLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
