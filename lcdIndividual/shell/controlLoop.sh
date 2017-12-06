if else 条件判断
eg:
	if condition
	then 
		command1
		command2
		command3
	else
		command
	fi

eg:
	if condition
	then
		command1
	elif condtion
	then	
		command2
	else
		command3
	fi

for 循环
 for var in item1 item2 ... itemN
 do
 	command1
	command2
done 
eg:
for loop in 1 2 3 4 5
do 
	echo "the value is : $loop"
done


eg: 
for str in "This is a string"
do
	echo $str
done

while 循环

while condition
do 	
	command
done

eg:
 int=1
while(($int<=5))
do
	echo $int
	let "int++"
done

无限循环
while :
do 
	command
done

while true
do
	command
done

until循环
until condition
do 
	command
done


case

































