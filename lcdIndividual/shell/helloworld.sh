#!/bin/bash
echo "Hello World !"
my_name="liuchaodong"//定义变量 首字母必须是字母中间不能有空格，可以使用下划线
echo $my_name //使用变量
echo ${my_name}
for skill in Ada Coffe Action Java; do
	echo "i am a good at ${skill}Script"
done
your_name="tom"
echo $your_name
echo ${your_name}
my_names="lcd sdsds sss"
readonly my_names
unset your_name
echo $your_name
if !your_name
then 
	echo "you_name不存在"



