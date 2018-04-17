//
//  AppDelegate.m
//  生日烟火
//
//  Created by rexsu on 2017/2/24.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import "BaseRequest.h"
#import "ViewController.h"
#import "WebVC.h"
#import "MBProgressHUD.h"


@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    BaseRequest * req = [[BaseRequest alloc] init];
    __weak __typeof(self)weakSelf = self;
//    MBProgressHUD * hub = [[MBProgressHUD alloc] initWithView:self]
    [req getRequestMethod:^(id respondsObj, NSError *error) {
        if (error == nil) {
            NSString * num = respondsObj[@"status"];
            if ([num isEqualToString:@"1"]) {
                //不跳转
                UIViewController * vc = [[ViewController alloc] init];
                [weakSelf setupRootViewcontroller:vc];
            }
            if ([num isEqualToString:@"0"]) {
                //跳转 设置webView为根控制器
                WebVC * vc = [[WebVC alloc] init];
                vc.URL = respondsObj[@"url"];
                [weakSelf setupRootViewcontroller:vc];
            }
        }
        NSLog(@"respondsObj = %@ \n  error =%@",respondsObj,error);
    }];
    return YES;
}

- (void)setupRootViewcontroller:(UIViewController *)vc{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [WXApi handleOpenURL:url delegate:self];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
