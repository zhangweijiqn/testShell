#!/usr/bin/env bash
#输出重定向
# 在 shell 程式中，最常使用的 FD (file descriptor) 大概有三个, 分别是:
# 0: Standard Input (STDIN)
# 1: Standard Output (STDOUT)
# 2: Standard Error Output (STDERR)
# 在标准情况下, 这些FD分别跟如下设备关联:
# stdin(0): keyboard  键盘输入,并返回在前端
# stdout(1): monitor  正确返回值 输出到前端
# stderr(2): monitor 错误返回值 输出到前端

ls diff_list.txt 1.txt 1>file.out 2>file.err  # 将标准输出重定向到file.out中，将file.err重定向输出到file.err(1.txt不存在)
bash run_all_get_tids.sh >file.out 2>file.err  # 通常1>可以省略成>

# 1>&2  正确返回值传递给2输出通道 &2表示2输出通道,如果此处错写成 1>2, 就表示把1输出重定向到文件2中.
# 2>&1 错误返回值传递给1输出通道, 同样&1表示1输出通道.
ls a.txt b.txt 1>file.out 2>&1 # 正确的输出和错误的输出都定向到了file.out这个文件中, 而不显示在前端

#错误信息输出
echo "errormsg" >& 2    #  标准错误
echo "infomsg" >& 1     #  标准输出

#调用多个python脚本顺序执行
python hello.py
if [ $?==0 ];then
    exit
else
        python world.py
fi

# wait 命令
cat test1 | uniq > newtest1 &
cat test2 | uniq > newtest2 &
wait
diff newtest1 newtest2
#为了比较newtest1和newtest2的不同，必须先让以上的两个cat命令成功并执行完成并生成newtest1和newtest2，否则diff的执行将错误
#wait就是保证以上命令执行完成之后才执行diff命令，在以上命令执行完成之前是不会执行diff命令的