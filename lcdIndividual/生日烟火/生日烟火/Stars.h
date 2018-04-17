//
//  Stars.h
//  生日烟火
//
//  Created by rexsu on 2017/2/24.
//  Copyright © 2017年 Winny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionFire)();
typedef void(^ActionBoom)();
@interface Stars : UIImageView
- (void)animationMove;

- (void)actionFireWithBlock:(ActionFire)actionFire;

- (void)actionBoomWithBlock:(ActionBoom)actionBoom;

@end
