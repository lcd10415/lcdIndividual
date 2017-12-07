//
//  Ctest.c
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/11/14.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#include "Ctest.h"
int main(){
    //二维数组
    int a[5][4];
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 4; j++) {
            int x = *(a[i] + j);
            printf("%d",x);
        }
    }
    int * p[4],m;
    for (m = 0; m < 4; m++) {
        p[m] = a[m];
    }
//    sizeof 返回整个数组的长度，而不是指向数组的指针长度
    //&数组名，生成的是一个指向整个数组的指针，而不是一个指向某个指针常量的指针
    printf("%lu",sizeof(a));
    
    
    
    return 0;
}
