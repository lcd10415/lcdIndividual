//
//  RunTime.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/11/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "RunTime.h"
#import <objc/message.h>

@implementation RunTime

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    
}
/*
Runtime
 导入objc/message.h文件
    1.objc_msgSend(receiver,selector)
 OBJC_EXPORT void objc_msgSend(void // id self, SEL op, ...) 该函数有两个参数1.id类型，2.SEL类型
    2.ivars:指向该类的成员变量列表
    3.methodLists:指向该类的实例方法列表，她将方法选择器和方法实现地址联系起来，
    4.protocols 指向该类的协议列表
    使用class_copyIvarList方法获取当前Model的所有成员变量
    使用ivar_getName方法获取成员变量的名称
    通过KVC来读取Model的属性值(encodeWithCoder:),以及给Model的属性赋值(initWithCoder:)
 
 模型转字典的时候
 1.调用class_copyPropertyList方法获取当前Model的所有属性
 2.调用property_getName获取属性名称
 3.根据属性名称生成getter方法
 4.使用objc_msgSend调用getter方法获取属性值(KVC)
 */
//模型转字典
-(NSDictionary *)keyValuesWithObject{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = propertyList[i];
        //生成getter方法，并用objc_msgSend调用
        const char *propertyName = property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id (*) (id,SEL)) objc_msgSend) (self,getter);
            /*判断当前属性是不是Model*/
            if ([value isKindOfClass:[self class]] && value) {
                value = [value keyValuesWithObject];
            }
            /**********************/
            if (value) {
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setObject:value forKey:key];
            }
        }
    }
    return dict;
}

//字典转模型
//1.根据字典的key字生成setter方法
//2.使用objc_msgSend调用setter方法为Model的属性赋值(KVC)
+(id)objectWithKeyValues:(NSDictionary *)aDictionary{
    id objc = [[self alloc] init];
    for (NSString *key in aDictionary.allKeys) {
        id value = aDictionary[key];
        /*判断当前属性是不是Model*/
        objc_property_t property = class_getProperty(self, key.UTF8String);
        unsigned int outCount = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
        objc_property_attribute_t attribute = attributeList[0];
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        if ([typeString isEqualToString:@"@\"TestModel\""]) {
            value = [self objectWithKeyValues:value];
        }
        /**********************/
        //生成setter方法，并用objc_msgSend调用
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void (*) (id,SEL,id)) objc_msgSend) (objc,setter,value);
        }
    }
    return objc;
}
@end
