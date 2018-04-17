//
//  DBTest.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/12/13.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "DBTest.h"
#import "FMDB.h"
#import "Student.h"

@interface DBTest()
@property (nonatomic,strong)FMDatabase * myDB;

@end

@implementation DBTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

//建立数据库
- (void)setup{
    NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString * dbPath = [documentDir stringByAppendingPathComponent:@"lcd.sqlite"];
    NSLog(@"path = %@",dbPath);
    _myDB = [FMDatabase databaseWithPath:dbPath];
    if (![_myDB open]) {
        NSLog(@"数据库不能被打开");
        return;
    }if ([_myDB open]) {
        NSLog(@"数据库打开");
    }
    [self buildTable];
    Student * stu = [[Student alloc] init];
    stu.name = @"LCD";
    stu.age = 25;
    stu.sex = @"man";
    stu.address = @"华阳";
    NSString * path = [[NSBundle mainBundle] pathForResource:@"8" ofType:@"png"];
    stu.photo = [NSData dataWithContentsOfFile:path];
    
    NSDictionary * data = @{
                            @"1":stu.name,
                            @"2":@(stu.age),
                            @"3":stu.sex,
                            @"4":stu.address,
                            @"5":stu.photo
                            };
    [self insertValue:data];
    [self getInfo];
    [self updateValue];
}
/*
 @property(nonatomic,assign)NSInteger  number;
 @property(nonatomic,strong)NSString * name;
 @property(nonatomic,strong)NSString * sex;
 @property(nonatomic,assign)NSInteger  age;
 @property(nonatomic,strong)NSString * address;
 */

//建表
- (void)buildTable{
   
//    BOOL result =  [_myDB executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL,sex text NOT NULL, age integer NOT NULL, address text NOT NULL);"];//blob对应OC中的NSData类型
    //3.创建表
    BOOL result = [_myDB executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
    
}
//插入值
- (void)insertValue:(NSDictionary*)data{
    BOOL result = [_myDB executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES (?, ?, ?)",@"dfsd",@(000),@"3434"];
    if (result) {
        NSLog(@"插入成功");
    }
    BOOL result1 = [_myDB executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES (?, ?, ?)",@"lcd",@(2),@"3434"];
    if (result1) {
        NSLog(@"插入成功");
    }
    BOOL result2 = [_myDB executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES (?, ?, ?)",@"wqe",@(431),@"3434"];
    if (result) {
        NSLog(@"插入成功");
    }
    BOOL result3 = [_myDB executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES (?, ?, ?)",@"erew",@(656),@"3434"];
    if (result3) {
        NSLog(@"插入成功");
    }
    BOOL result4 = [_myDB executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES (?, ?, ?)",@"gsg",@(768),@"3434"];
    if (result4) {
        NSLog(@"插入成功");
    }
}
//更新
-(void)updateValue{
    [_myDB executeUpdate:@"UPDATE t_student SET age = ? WHERE name = ?",@(110),@"123"];
    BOOL sueess =  [_myDB executeQuery:@"SELECT * FROM t_student"];
    if (sueess) {
        NSLog(@"查询成功");
    }
}
//获取特定的资料
- (void)getInfo{
    FMResultSet * result = [_myDB executeQuery:@"SELECT name,age FROM t_student"];
    while ([result next]) {
        NSString * name = [result stringForColumn:@"name"]; //转成OC类型
        NSLog(@"name = %@",name);
        int age = [result intForColumn:@"age"];
        NSLog(@"%i",age);
    }
    [result close];//关闭结果
}
//快速取得资料
- (void)getName{
    //某个名字的地址
    NSString * nameAddress = [_myDB stringForQuery:@"SELECT address FROM t_student WHERE name = ?",@"lcd"];
    NSLog(@"查找姓名是LCD的地址%@",nameAddress);
}
- (void)getAge{
    //某个名字的地址
     int ageAddress = [_myDB intForQuery:@"SELECT age FROM t_student WHERE Name = ?",@"lcd"];
    NSLog(@"查找姓名是LCD的年龄%d",ageAddress);
}





































@end
