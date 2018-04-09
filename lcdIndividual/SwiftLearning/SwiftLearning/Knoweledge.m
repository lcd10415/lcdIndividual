//
//  Knoweledge.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Knoweledge.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "SwiftLearning-Swift.h"
#import <Contacts/Contacts.h>
#import <CoreLocation/CoreLocation.h>
#import <Security/Security.h>
#import <SystemConfiguration/SystemConfiguration.h>

#define PUSH(x) AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;[(UINavigationController*)appdelegate.window.rootViewController pushViewController:x animated:YES];

#define POP AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;[(UINavigationController*)appdelegate.window.rootViewController popViewControllerAnimated:YES];

#define POPROOT OGPAppDelegate *appdelegate=(OGPAppDelegate *)[UIApplication sharedApplication].delegate;[(UINavigationController*)appdelegate.window.rootViewController popToRootViewControllerAnimated:YES];

#define IOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)
#define IPHONE_4INCH ([UIScreen mainScreen].bounds.size.height > 480.0f)
// 随机颜色
#define RANDOM_COLOR [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

@interface Knoweledge()<CLLocationManagerDelegate>

//@property (nonatomic,strong)UIImageView * leftView;
@property (nonatomic,strong)UIButton * rightView;

//@property (nonatomic,strong)UITextFieldViewMode rightView;
@end

@implementation Knoweledge
//设置渐变色
-(void)setGradientColor{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor, (__bridge id)[UIColor grayColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 100, 300, 2);
    [self.vc.view.layer addSublayer:gradientLayer];
}

//使用drowRect绘制简单图形
- (void)drawImage{
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置绘制地区的颜色
    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //设置绘制的位置和大小
    CGContextFillRect(context, CGRectMake(0, 100, 100, 100));
    NSString * text = @"文字";
    UIFont * font   = [UIFont systemFontOfSize:14];
    //设置文字的位置
    [text drawAtPoint:CGPointMake(0, 200) withAttributes:font.fontDescriptor.fontAttributes];
    UIImage * img  = [UIImage imageNamed:@""];
    [img drawInRect:CGRectMake(0, 300, 100, 100)];
}
//可变数组与不可变数组之间的转换
-(void)exchangeArray{
    NSMutableArray * mutablearray=[[NSMutableArray alloc]initWithCapacity:0];
    NSArray * copyarray=[mutablearray copy];
    copyarray=@[@"1",@"2",@"3"];
    NSArray * array=[[NSArray alloc]init];
    NSMutableArray * copymutablearray=[array mutableCopy];
    
    [copymutablearray setObject:@"加入到第一位" atIndexedSubscript:0];
    [copymutablearray addObject:@"排序加入"];
    [copymutablearray addObjectsFromArray:copyarray];
}
// 快速求和，最大值，最小值，平均值
-(void)quickCalculate{
    NSArray *array = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", @"10", nil];
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
}

//对控件的旋转，平移，缩放，复位
-(void)doAnimation{
    UIView * _pingyibu = [UIView new];
    //平移
    CGAffineTransform transForm = _pingyibu.transform;
    _pingyibu.transform=CGAffineTransformTranslate(transForm, 100, 0);
    //旋转
    _pingyibu.transform = CGAffineTransformRotate(transForm, M_PI_4);
    //缩放按钮
    _pingyibu.transform = CGAffineTransformScale(transForm, 1.2, 1.2);
    //初始化复位
    _pingyibu.transform = CGAffineTransformIdentity;
}
//设置label的行间距
- (void)setDistance{
    UILabel * _xuanzhuanla = [UILabel new];
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:_xuanzhuanla.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [_xuanzhuanla.text length])];
    _xuanzhuanla.attributedText = attributedString;
}
//让应用直接闪退
-(void)applicationCrash{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}
//手机震动  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);

//生成手机唯一ID：UUID
-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}
// 获取当前时间和时间戳
- (void)getCurrentData{
    //当前时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    //当前时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    long s = [timeString intValue];
}

// 对比时间差
-(int)max:(NSDate *)datatime
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSDate *  senddate=[NSDate date];
    NSString *  locationString=[dateFormatter stringFromDate:senddate];
    NSDate *date=[dateFormatter dateFromString:locationString];
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date timeIntervalSinceDate:datatime];
    int days=((int)time)/(3600*24);
    return days;
}

// 使提示框消失（定时）  [alu dismissWithClickedButtonIndex:0 animated:NO];
- (void)setupTitleColor{
    UIColor * color=[UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes = dict;
}

//请求定位权限以及定位属性
- (void)locationAuth{
    //定位管理器
    CLLocationManager * _locationManager = [[CLLocationManager alloc]init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [_locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        _locationManager.distanceFilter=distance;
        //启动跟踪定位
        [_locationManager startUpdatingLocation];
    }
}

//通过经纬度计算距离
- (BOOL)getDistance{
    BOOL JuLi=NO;
    CLLocationDegrees oldlat = 23.0;
    CLLocationDegrees oldlong = 23.0;
    CLLocationDegrees nowlat = 23.0;
    CLLocationDegrees nowlong = 23.0;
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:oldlat  longitude:oldlong];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:nowlat longitude:nowlong];
    CLLocationDistance kilometers=[orig distanceFromLocation:dist];
    NSLog(@"距离:%f",kilometers);
    if (kilometers>=10) {
        JuLi=YES;
    }
    else{
        JuLi=NO;
    }
    return JuLi;
}

/**
 *  弹出对话框的动画
 *
 *  @param changeOutView 要执行的view
 *  @param dur           动画时长
 */
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = dur;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

//设置TextField左右视图
-(id)initWithFrame:(CGRect)frame drawingLeft:(UIImageView *)icon drawingRight:(UIButton *)bu{
    self = [super init];
    if (self) {
//        self.leftView = icon;
//        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightView= bu;
//        self.rightViewMode=UITextFieldViewModeAlways;
    }
    return self;
}
-(void)leftViewRectForBounds:(CGRect)bounds{
//    CGRect iconRect = [super leftViewRectForBounds:bounds];
//    iconRect.origin.x += 5;// 右偏10
}
-(void)rightViewRectForBounds:(CGRect)bounds
{
//    CGRect burect=[super rightViewRectForBounds:bounds];
//    burect.origin.x +=-10;
}

//获取版本号提示版本更新
-(void)VersionButton
{
    NSString * string=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?id=??????????"] encoding:NSUTF8StringEncoding error:nil];
    if (string!=nil && [string length]>0 && [string rangeOfString:@"version"].length==7) {
        [self checkenAppUpdate:string];
    }
}
-(void)checkenAppUpdate:(NSString *)appinfo
{
    NSString * version=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString * appInfo1=[appinfo substringFromIndex:[appinfo rangeOfString:@"\"version\":"].location+10];
    appInfo1=[[appInfo1 substringToIndex:[appInfo1 rangeOfString:@","].location] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    if (![appInfo1 isEqualToString:version]) {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"新版本%@, 已经发布",appInfo1] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        alert.delegate=self;
        [alert addButtonWithTitle:@"前往更新"];
        [alert show];
        alert.tag=20;
    }
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1 & alertView.tag==20) {
        NSString * url=@"https://appsto.re/cn/-naScb.i";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

//返回应用程序名称
+(NSString *) getAppName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}
//返回应用版本号
+(NSString *) getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}
+(NSString *) getAppBundleVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}
//设备型号
+(NSString *) getSystemName{
    return [[UIDevice currentDevice] systemName];
}
//设备版本号
+(NSString *) getSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

// 判断字符串中是否含有中文
-(BOOL)isChinese:(NSString *)str{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

/** 解决手势冲突 */
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if ([touch.view isDescendantOfView:cicView]) {
//        return NO;
//    }
//    return YES;
//}

- (void)getWIFIName{
//    NSString *wifiName = @"Not Found";
//    CFArrayRef myArray = (id)CNCopySupportedInterfaces();
//    if (myArray != nil) {
//        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
//        if (myDict != nil) {
//            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
//            wifiName = [dict valueForKey:@"SSID"];
//        }
//    }
}

// 判断两个数组是否相同
- (void)compareTwoArray{
    NSArray *array1 = [NSArray arrayWithObjects:@"a", @"b", @"c",  nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"d", @"a", @"c",  nil];
    bool bol = false;
    //创建俩新的数组
    NSMutableArray *oldArr = [NSMutableArray arrayWithArray:array1];
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:array2];
    //对数组1排序。
    [oldArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return obj1 > obj2;
    }];
    //对数组2排序。
    [newArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return obj1 > obj2;
    }];
    if (newArr.count == oldArr.count) {
        bol = true;
        for (int16_t i = 0; i < oldArr.count; i++) {
            
            id c1 = [oldArr objectAtIndex:i];
            id newc = [newArr objectAtIndex:i];
            
            if (![newc isEqualToString:c1]) {
                bol = false;
                break;
            }
        }
    }
    if (bol) {
        NSLog(@" ------------- 两个数组的内容相同！");
    }
    else {
        NSLog(@"-=-------------两个数组的内容不相同！");
    }
}

// 使应用在后台运行
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    __block UIBackgroundTaskIdentifier bgTask = UIBackgroundTaskInvalid;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

//计算一段NSString在视图中渲染出来的尺寸
+ (void)sizeOfString:(NSString *)textString font:(UIFont *)font bound:(CGSize)bound {
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    if (font == nil) {
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    NSDictionary * attributes = @{NSFontAttributeName : font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:textString attributes:attributes];
//    return [TTTAttributedLabel sizeThatFitsAttributedString:attributedString
//                                            withConstraints:CGSizeMake(bound.width, 999)
//                                     limitedToNumberOfLines:0];
}

- (void)getName{
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"Family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"~~~~~~~~");
    }
}
+ (NSString *)getDeviceId
{
//    NSString * currentDeviceUUIDStr = [SSKeychain passwordForService:@" "account:@"uuid"];
//    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
//    {
//        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//        [SSKeychain setPassword: currentDeviceUUIDStr forService:@" "account:@"uuid"];
//    }
//    return currentDeviceUUIDStr;
    return @"";
}

































@end
