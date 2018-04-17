//
//  BaseRequest.m
//  生日烟火
//
//  Created by ReleasePackageMachine on 2017/11/7.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import "BaseRequest.h"
#import "AFNetworking.h"
#define URL "http://1114600.com:8080/appgl/appShow/getByAppId?appId=xy20171028001"


@implementation BaseRequest
+(instancetype)shareInstance:(Method)methodName params:(NSDictionary *)params{
    static BaseRequest * single = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[BaseRequest alloc] init];
        
        //todo
        [single requestMethod:methodName params:params];
    });
    return single;
}
-(void)requestMethod:(Method)name params:(NSDictionary *)params{
    switch (name) {
            
        //todo
        case GET:
            [self getRequestMethod:nil];
            break;
        case POST:
            [self postRequestMethod:nil params:params];
            break;
        default:
            break;
    }
    
}
-(void)getRequestMethod:(ReturnValue)block{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager GET:@URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
}
-(void)postRequestMethod:(ReturnValue)block params:(NSDictionary *)params{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager POST:@URL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
}

@end
