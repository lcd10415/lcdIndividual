#!/bin/bash
#author:liuchaodong
#url:www.xxx.com

array=(A,B,"C")
array1[0]=12
array1[1]=13
array1[2]=14

echo "${array[*]}"
echo "${array1[@]}"

# awk expr 实现简单的数学运算 两个数相相加使用的是反引号`而不是单引号'

val=`expr 2 + 2`
echo "两数之和：$val"
a=10
b=23

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $a / $b`
echo "a / b : $val"

if [ $a == $b ]
then
	echo "a 等于 b"
fi
if [ $a != $b ]
then
	echo "a不等于b"
fi
#乘法(*)前边必须加入反斜杠才能实现乘法
#if...then...fi是条件语法
#在mac中shell的expr语法是：$((表达式))，此处表达式中的"*"不需要转义符号"\"

#关系运算符 -eq 相等=   -ne 不相等!=   -gt 大于>   -lt 小于<  -ge 大于等于>=  -le  小于等于<=

a=23
b=23
if [ $a -eq $b ]
then
	echo "a等于b"
else
	echo "a不等于b"
fi







 












 
