//
//  BridgeOC.m
//  SwiftLearning
//
//  Created by ReleasePackageMachine on 2017/9/5.
//  Copyright © 2017年 com.1ktower.snakepop. All rights reserved.
//

#import "BridgeOC.h"
#import <Foundation/Foundation.h>

@implementation BridgeOC
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString * strOC = [NSString stringWithFormat:@"qwertyui"];
        CFStringRef strC = (__bridge CFStringRef) strOC;
        NSLog(@"strC:%@ ================ strOC:%@",strC,strOC);
        
        NSString * strOC2 = [NSString stringWithFormat:@"123456"];
        CFStringRef strC2 = (__bridge_retained CFStringRef)strOC2;
        CFRelease(strC2);
        NSLog(@"strOC:%@ =============== strC2: %@",strOC2,strC2);
    }
    return self;
}


//正则表达式
/*
   1.验证用户名和密码：”^[a-zA-Z]\w{5,15}$”

　　2.验证电话号码：（”^(\d{3,4}-)\d{7,8}$”）

　　eg：021-68686868 0511-6868686；

　　3.验证手机号码：”^ 1 [3|4|5|7|8] [0-9] \d{8} $”； ^1[]$

　　4.验证身份证号（15位或18位数字）：”\d{14} [[0-9],0-9xX]”；

　　5.验证Email地址：(“^\w+([-+.]\w+)@\w+([-.]\w+).\w+([-.]\w+)*$”)；

　　6.只能输入由数字和26个英文字母组成的字符串：(“^[A-Za-z0-9]+$”) ;

　　7.整数或者小数：^[0-9]+([.]{0,1}[0-9]+){0,1}$

　　8.只能输入数字：”^[0-9]*$”。

　　9.只能输入n位的数字：”^\d{n}$”。

　　10.只能输入至少n位的数字：”^\d{n,}$”。

　　11.只能输入m~n位的数字：”^\d{m,n}$”。

　　12.只能输入零和非零开头的数字：”^(0|[1-9][0-9]*)$”。

　　13.只能输入有两位小数的正实数：”^[0-9]+(.[0-9]{2})?$”。

　　14.只能输入有1~3位小数的正实数：”^[0-9]+(.[0-9]{1,3})?$”。

　　15.只能输入非零的正整数：”^+?[1-9][0-9]*$”。

　　16.只能输入非零的负整数：”^-[1-9][]0-9″*$。

　　17.只能输入长度为3的字符：”^.{3}$”。

　　18.只能输入由26个英文字母组成的字符串：”^[A-Za-z]+$”。

　　19.只能输入由26个大写英文字母组成的字符串：”^[A-Z]+$”。

　　20.只能输入由26个小写英文字母组成的字符串：”^[a-z]+$”。

　　21.验证是否含有^%&’,;=?$\”等字符：”[^%&',;=?$\x22]+”。
                            
   22.只能输入汉字：”^[\u4e00-\u9fa5]{0,}$”。
                            
   23.验证URL：”^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$”。
                            
　 24.验证一年的12个月：”^(0?[1-9]|1[0-2])$”正确格式为：”01″～”09″和”10″～”12″。

   25.验证一个月的31天：”^((0?[1-9])|((1|2)[0-9])|30|31)$”正确格式为；”01″～”09″、”10″～”29″和“30”~“31”。
    
   26.获取日期正则表达式：\d{4}[年|-|.]\d{\1-\12}[月|-|.]\d{\1-\31}日?
                            
   27.匹配双字节字符(包括汉字在内)：[^\x00-\xff]
                            
   28.匹配空白行的正则表达式：\n\s*\r
                            
  　29.匹配HTML标记的正则表达式：<(\S?){FNXX==XXFN}>.?</>|<.? />
                            
   30.匹配首尾空白字符的正则表达式：^\s|\s$
                            
   31.匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
                            
   　32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
                            
 　　33.匹配腾讯QQ号：[1-9][0-9]{4,}
                            
  　34.匹配中国邮政编码：[1-9]\d{5}(?!\d)
                            
  　35.匹配ip地址：((2[0-4]\d|25[0-5]|[01]?\d\d?).){3}(2[0-4]\d|25[0-5]|[01]?\d\d?)。
 
 */
                            
//过滤掉纯数字
- (BOOL)validateNumber: (NSString *)textStr{
    NSString * number = @"^[0-9]+$";
    NSPredicate * numberPre = [NSPredicate predicateWithFormat:@"SELF MATCH %@",number];
    return [numberPre evaluateWithObject:textStr];
    //@"^[0-9]+$" 它表示了字符串中只能包含 >= 1个0-9的数字
}
/*
 * '^' 和 '$' 分别支出一个字符串的开始和结束 eg: "^one" 表示所有以"one"开始的字符串("one cat","one 123",...)
 * "a dog$"：表示所以以"a dog"结尾的字符串（"it is a dog"，·····）
 * "^apple$"：表示开始和结尾都是"apple"的字符串，这个是唯一的~
 */

/*
 *可以用大括号括起来{} : 表示一个重复的具体范围
 eg: "ab{4}" 表示一个字符串有一个a跟着4个b("abbbb")
 */























@end
