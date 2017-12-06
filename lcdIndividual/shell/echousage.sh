#!/bin/bash
echo "this is a echo test shell"
echo "\"this is Escape character\""
readonly name="sssd"

echo "$name It is a test"
echo -e "OK! \n"
echo "this is a echo test"
echo -e "OK! \c"
echo "this is a echo test "
#原样输出字符串，不能进行转义或者变量
echo '"$name\"'
echo `date`
