//
//  Tools.m
//  
//
//  Created by Liuchaodong on 2018/3/20.
//

#import "Tools.h"

@interface Tools()<NSURLSessionDelegate>
@property(nonatomic,strong)NSOperationQueue * queue;
@property(nonatomic,strong)NSURLSession     * session;
@end

@implementation Tools
+(instancetype)shareInstance{
    static Tools * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[Tools alloc] init];
    });
    return tool;
}
//app切换到后台进行下载 ,当进程被杀死的时候，在appdidregiestActive方法中，停止所有下载任务
-(NSURLSession *)downloadWithAppBackgroud{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.onektower.snakepop"];
        self.queue = [[NSOperationQueue alloc]init];
        self.queue.maxConcurrentOperationCount = 1; //同时支持的最多的下载次数
        self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:self.queue];
    });
    return self.session;
    
}

//保存用户登录信息
/*
 1.单例模式，登录后把用户数据存储在单例对象
 2.NSUserDefaults 数据存储后可以关闭app后依然存在，只有在卸载app或者手动删除，数据才会消失
 3.钥匙串，数据可以删除app后依然存在，钥匙串由操作系统保护并且存储后的数据是比较安全的，常用来存储一些密码和私钥的。
 */

@end
