//
//  FileHandler.m
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import "FileHandler.h"
#import "SingleFile.h"

@implementation FileHandler

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self filePath];
    }
    return self;
}

- (NSString *)filePath{
    //Documents 用来存储永久性的数据的文件 程序运行时所需要的必要的文件都存储在这里（数据库）iTunes会自动备份这里面的文件
    NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"documentPath=%@",documentPath);
    //Library：用于保存程序运行期间生成的文件
    NSString * libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSLog(@"libraryPath = %@",libraryPath);
    //Caches：文件夹用于保存程序运行期间产生的缓存文件
     NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    return documentPath;
}
- (void)writeFile{
    NSString * str = @"this is a file example";
    NSString * path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"file.txt"];
//    path = [path stringByAppendingString:@"/file.txt"];
    
    //写入文件  支持简单文件 NSString, NSArray, NSDictionary, NSData
    [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //读取文件
    NSString *fileStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"读取的文件为%@",fileStr);
    
    SingleFile * file = [[SingleFile alloc] init];
    file.name = @"你大爷的";
    file.address = @"中和大道";
    file.age = 18;
    path = [path stringByAppendingString:@"/file.txt"];
    NSMutableData * data = [NSMutableData data];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:file forKey:@"file"];
    [archiver finishEncoding];
    [data writeToFile:path atomically:YES];
    
//    反归档
    NSData * myData = [NSData dataWithContentsOfFile:path];
    //创建反归档对象
    NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    SingleFile * singleFile = [unarchiver decodeObjectForKey:@"file"];
    [unarchiver finishDecoding];
    NSLog(@"name=%@ address=%@ age=%d",singleFile.name,singleFile.address,singleFile.age);
}

- (void)createFileAndDirectory{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * path = [self filePath];
    path = [path stringByAppendingPathComponent:@"iOS"];
    BOOL success = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    success ? NSLog(@"创建文件夹成功") : NSLog(@"创建文件夹失败");
    
    
    path = [path stringByAppendingPathComponent:@"iOS.txt"];
    NSString * content = @"写入数据";
    success = [content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    success ? NSLog(@"写入文件成功") : NSLog(@"写入文件失败");
    NSString * file = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",file);
    BOOL isExist = [fileManager fileExistsAtPath:path];
    isExist ? NSLog(@"存在") : NSLog(@"不存在");
    
}
@end









































