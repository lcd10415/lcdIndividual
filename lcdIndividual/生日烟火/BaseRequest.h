//
//  BaseRequest.h
//  生日烟火
//
//  Created by ReleasePackageMachine on 2017/11/7.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    GET,
    POST
}Method;
typedef void(^ReturnValue)(id respondsObj,NSError * error);

@interface BaseRequest : NSObject

+(instancetype)shareInstance:(Method)methodName params:(NSDictionary *)params;
-(void)getRequestMethod:(ReturnValue)block;
@end
