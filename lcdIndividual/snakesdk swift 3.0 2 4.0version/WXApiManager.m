//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
//    if ([resp isKindOfClass:[SendAuthResp class]]) {
//        switch (resp.errCode) {
//            case 0:
//                NSDictionary * dict = @{"code":resp.code}
//                break;
//                
//            default:
//                break;
//        }
//    }
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg = @"";
        switch (resp.errCode) {
            case 0:
                strMsg = @"success";
                break;
                
            case -2:
                strMsg = @"cancel";
                break;
                
            default:
                strMsg = @"failed";
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WechatPay" object:strMsg];
    }

}


@end
