#!/usr/bin/env bash
export -p   #查看当前的环境
sleep 120   #等待两分钟
readonly hours_per_day=24 days_per_week=7   #定义不可修改变量
unset hours_per_day #删除变量

### args ###
echo ${count:=0} #如果变量count存在并且不是null，则返回它的值；否则设置为0
set -- hello "hi there" greetings   # 设置新的位置参数
echo there are $# total arguments   # $#参数的个数
for i in $*     #循环处理每一个参数，$*,$@表示所有的命令行参数
do  echo i is $i
done
for i in "$@"     # $*加了双引号，会保留真正的参数值
do  echo i is $i
done

### 退出状态 ###
# 0表示成功，其他状态均为失败
echo $? # $?保存了最近一次执行的程序的退出状态
exit 0  # 以状态0退出

#得到结果
first_row = `head -1`

### 算数运算 ###
# $((...))中
echo $((3 && 4))

### 变量 ###
variable1=abc                       #（1）字符串中间没有空格时可以不加双引号；
variable2=" def"                    #（2）等号前后不要加空格，否则会报错
echo $variable2                     #变量引用时前面要加$,或者${}来引用
echo ${variable2}
echo "$variable1,$variable2"
echo "hello \n happy new year!"     # echo 支持转移字符，\b退格
printf "hello,world!\n a\b"         # printf输出，不会自动换行，需要显示\n
printf "hello,%s and %s\n" ${variable1} ${variable2}    # %s字符串，%d十进制整数，变量依次写在后面

### if-elif-else-fi ###
if grep hello test.txt > /dev/null  # /dev/null的内容将不会被保留，这里只是用来判断执行的状态
then echo hello
elif !grep test test.txt > /dev/null    # ! not, || or , && and
then echo test
else echo fail
fi

### test + if ###
#包含两种形式
# test expression
# [expression]
#字符串比较=,整型比较 n1 -eq n2, n1 -ne n2, n1 -lt n2, n1 -gt n2, n1 -le n2, n1 -ge n2
if test "$str1" = "$str2"
then echo equal
fi
if [ "$str1" = "$str2" ]  #和上面的形式等价, []中的变量要加双引号,[]内前后和[]要有空格
then echo equal
elif [ -n "$str1" ] || [-n "$str2"] #多个条件，-n string是非null
then echo null
fi
if [-f "$file"] # -f 判断是否为一般文件
then echo "$file is a regular file"
elif [-d "$file"]   # -d 判断是否为目录
then echo "$file is a directory"
elif [-x "$file"]   # -x判断是否是可执行的
then echo "$file is executable"
fi
if [$# -ne 1]
then
    echo Usage: finduser username >$2
    exit 1
fi

### case ###
case $1 in
-f)
    echo file
    ;;
-d | --directory)
    echo directory
    ;;
*)
    echo unkown option
    exit 1
esac

### for (while,until) ###
for i in "$*"
do
    echo $i
    if [ "$i" = "3" ]
    then
        break
    fi
done
for((i=2;i<=11;i++));
do
    bash test.sh $i
done

### 函数 ###
equal(){
    case $1 in
    "$2") return 0 ;;
    esac
    return 1
}
if equal "$a" "$b"  #参数传递
then echo equal
fi


