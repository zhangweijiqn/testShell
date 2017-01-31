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

### 算数运算 ###
# $((...))中
echo $((3 && 4))

### 退出状态 ###
# 0表示成功，其他状态均为失败
echo $? # $?保存了最近一次执行的程序的退出状态
exit 0  # 以状态0退出