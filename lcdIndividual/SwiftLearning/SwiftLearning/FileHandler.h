//
//  FileHandler.h
//  SwiftLearning
//
//  Created by Liuchaodong on 2018/3/8.
//  Copyright © 2018年 com.1ktower.snakepop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileHandler : NSObject
- (NSString *)filePath;
- (void)writeFile;
- (void)createFileAndDirectory;
@end
