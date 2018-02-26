//
//  ViewController.m
//  WkWebViewDemo
//
//  Created by Liuchaodong on 2018/1/16.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"


@interface ViewController ()<WKNavigationDelegate,WKUIDelegate>

@property(nonatomic,strong)WKWebView *myWebView;
@property(nonatomic,strong)WKWebViewConfiguration * webConfig;
@property(nonatomic,copy)NSString * urlStr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(WKWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[WKWebView alloc]initWithFrame: CGRectMake(0, 0, kWidth, kHeight) configuration: self.webConfig];
        _myWebView.UIDelegate = self;
        _myWebView.navigationDelegate = self;
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:_urlStr];
        [_myWebView loadRequest:request];
    }
    return _myWebView;
}

-(WKWebViewConfiguration *)webConfig{
    if (!_webConfig) {
        _webConfig = [[WKWebViewConfiguration alloc] init];
        WKUserContentController * userC = [[WKUserContentController alloc]init];
        _webConfig.userContentController = userC;
        _webConfig.preferences.javaScriptEnabled = YES;
    }
    return _webConfig;
}
@end
