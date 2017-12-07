//
//  UniteC.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/9/5.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "stdio.h"
extern "C" {
    int main() {
        int f,c;
        int l,u,s;
        l = 0;
        u = 300;
        s = 20;
        
        f = l;
        while (f <= u) {
            c = 5 * (f - 32) /9;
            printf("%d \t %d",f,c);
            f = f + s;
        }
        return f;
    }
}
