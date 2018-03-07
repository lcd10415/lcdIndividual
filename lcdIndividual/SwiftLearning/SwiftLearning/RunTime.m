//
//  RunTime.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/11/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "RunTime.h"
#import "Lock.h"
#import <objc/message.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface RunTime()
@property (nonatomic,weak)UIViewController * currentVC;
@end

@implementation RunTime

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

//利用runtime实现属性的get set方法
-(void)setCurrentVC:(UIViewController *)currentVC{
    objc_setAssociatedObject(self, @selector(currentVC), currentVC, OBJC_ASSOCIATION_ASSIGN);
}
-(UIViewController *)currentVC{
    return objc_getAssociatedObject(self, _cmd);
}

//保存gif图到相册，直接把APNG,GIF写入相册
- (void)setup{
    ALAssetsLibrary * lib = [[ALAssetsLibrary alloc]init];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"" ofType:nil];
    NSData * data = [NSData dataWithContentsOfFile:path];
    [lib writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        
    }];
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
        unsigned int    outCount    = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
        objc_property_attribute_t  attribute      = attributeList[0];
        NSString *typeString = [NSString stringWithUTF8String:attribute.value];
        if ([typeString isEqualToString:@"@\"TestModel\""]) {
                    value    = [self objectWithKeyValues:value];
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
//导入头文件 <objc/runtime.h> <objc/message.h>
/*
 类在runtime中的表示
 struct objc_class{
    Class isa; 指针， 实例的isa指向类对象，类对象的isa指向元类
    Class super_class 指向父类
    const char * name 类名
    struct objc_ivar_list * ivars 成员变量列表
    struct objc_method_list **methodLists 方法列表
    struct objc_cache *cache 缓存，一种优化，掉用过的方法存入缓存列表，下次调用先找到缓存
    struct objc_protocol_list * protocols协议列表
 }
 
 [target doSomething];会被转化成 objc_msgSend(target,@selector(doSomething));
 
 Runtime用法：
 在OOP术语中，消息传递是指一种在对象之间发送和接收消息的通信模式。 在Objective-C中，消息传递用于在调用类和类实例的方法，即接收者接收需要执行的消息
 
 1.消息机制 objc_msgSend(target,@selector(doSomething))
 2.获取对象的所有属性，方法，成员变量，和遵循的协议和添加属性、方法等  ivar表示成员变量 class_addIvar class_addMethod class_addProperty class_copyProtocolList 获取协议列表
    class_copyPropertyList  获取属性列表
    class_copyMethodList    获取方法列表
    class_copyIvarList      获取成员变量列表
    ivar_getName            获取成员变量名字
 3.方法交换Method Swizzling  方法替换
 4.动态添加方法和属性(这个就是Catory添加属性的实现本质)
 5.实现NSCoding的自动归档和自动解档
 6.消息转发机制
 */
- (void)getObjectInfo{
    unsigned int count;
    
    //获取Lock类的属性列表
    objc_property_t * propertyList = class_copyPropertyList([Lock class], &count);
    for (unsigned int i = 0; i<count; i++) {
        const char * propertyName = property_getName(propertyList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
    }
    free(propertyList);
    
    //获取Lock类的方法列表
    Method * methodLists = class_copyMethodList([Lock class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodLists[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(method)));
    }
    free(methodLists);
    
    //获取成员变量列表
    Ivar * ivarList = class_copyIvarList([Lock class], &count);
    for (unsigned int i=0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char * ivarName = ivar_getName(myIvar);
        NSLog(@"%@",[NSString stringWithUTF8String:ivarName]);
    }
    free(ivarList);
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    unsigned int count = 0;
//    成员变量列表
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
//        成员变量名
        const char * name = ivar_getName(ivar);
        //归档
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (unsigned int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


















































@end
