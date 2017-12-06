#!/bin/bash

printWithParams(){
	echo "first: $1 !"
	echo "second: $2 !"
	echo "参数总数：$# !"
	echo "作为一个字符串输出所以参数 $* !"



}
printWithParams 12 21
funWithReturn(){
	 echo "这个函数会对输入的两个数字进行相加运算..."
    echo "输入第一个数字: "
    read aNum
    echo "输入第二个数字: "
    read anotherNum
    echo "两个数字分别为 $aNum 和 $anotherNum !"
    return $(($aNum+$anotherNum))
}
funWithReturn
echo "输入的两个数字之和为 $? !"







