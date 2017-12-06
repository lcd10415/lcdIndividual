#!/bin/bash
a="asndkad"
b="sdqiowrjoqwi"
if [ $a = $b ]
then
	echo "a等于b"
else
	echo "a不等于b"
fi

if [ -z $a ]
then
	echo "-a $a : 字符串长度为0"
else 
	echo "-a $a ：字符串不为0"
fi

file="/Users/a1/Desktop/shell/helloworld.sh"

if [ -r $file ]
then 
	echo "文件可读"
else
	echo "文件不可读"
fi

if [ -w $file ]
then
	echo "文件可写"
else 
	echo "文件不可写"
fi
# 文件 -r 可读  -w 可写  -x 可执行  -f 普通文件  -d 目录  -s 不为空  -e 存在  









