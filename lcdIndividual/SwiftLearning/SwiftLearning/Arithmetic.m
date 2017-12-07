//
//  Arithmetic.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/9/5.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "Arithmetic.h"
#define Length 8

@interface Arithmetic()

@end

@implementation Arithmetic

//1.选择排序：一种简单直观的排序算法，无论什么数据进去都是 O(n?) 的时间复杂度。所以用到它的时候，数据规模越小越好。唯一的好处可能就是不占用额外的内存空间了吧
/*
 算法步骤
 1. 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 2. 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 3. 重复第二步，直到所有元素均排序完毕。
 */
#pragma mark ***************  选择排序  *******************
- (void)mb_selectionSort{
//    for (int i = 0; i < self.count; i++) {
//        for (int j = i + 1; j < self.count ; j++) {
//            if (self.comparator(self[i],self[j]) == NSOrderedDescending) {
//                [self mb_exchangeWithIndexA:i  indexB:j];
//            }
//        }
//    }
}
#pragma mark =================  冒泡排序  ==============
- (void)bubblingCalculate{
    int i,j,temp,number[Length] = {102,45,56,32,847,121,555,32};
    for (i = 0; i < Length; i++) {
        for (j = Length - 1; j > i; j--) {
            if (number[j] < number[j-1]) {//相邻两个数比较，由小到大顺序
//              if (number[j] < number[j-1])  相邻两个数比较，由大到小顺序
                //交换两个数
                temp = number[j-1];
                number[j-1] = number[j];
                number[j] = temp;
            }
        }
    }
    
    for (i = 0; i<Length; i++) {
        NSLog(@"%d",number[i]);
    }
    /*执行次数
     (n-1)+(n-2)+.......+3+2+1 = (n-1)*n/2 = (n^2 - n)/2 时间复杂度O(n^2)
     */
    
}
#pragma mark =================选择排序==============
/*选择排序基本思想：
 1、将所有数种最小的数与a[0]交换
 2、将a[1]到a[n - 1]中最小的数与a[1]交换
 3、....
 没比较一趟找出一个未经排序的数中最小的数，共比较n - 1轮
 时间复杂度：
 每趟先从s[i]+1~s[n-1]找出最大元素或者最小元素，与s[i]进行比较、交换；
 总的比较次数为: n(n-1)/2，即时间复杂度为: O(n^2)
 */
- (void)selectSort{
    int num[Length] = {102,45,56,32,847,121,555,32};
    int i,j,k,t;
    for (i = 0; i<Length; i++) {
        k = i;
        for (j = i+1; j < Length; j++) {//找出没有排序中最小的数
            if (num[j] < num[k]) {//从小到大
                 //if (num[j] > num[k]) 从大到小
                k = j;
            }
        }
    }
    //将没有排序的最小的数放在最前面
    t = num[k];
    num[k] = num[i];
    num[i] = t;
}





















@end
