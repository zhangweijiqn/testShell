#!/bin/ bash

### tr ###
# 转换/删除字符,如同一个过滤器
# tr [options] source-char-list replace-char-list
tr "abc" "abcd"     #从标准输入中，将abc字符替换为abcd
tr -d "abc"         #-d删除，将标准输入中出现的abc删除

### 重定向 ###
# 在登录时，linux会将默认的标准输入，输出，错误输出安排为终端
# 重定向标准输入: program < file
tr -d "\r" < abc.txt                    # 输入为abc.txt
# 重定向标准输出: program > file , >> 可以附加到文件末尾
tr -d "\r" < abc.txt > unix-file.txt    # 输入为abc.txt，输出重定向到unix-file.txt
# 管道: program1 | program2，将program1的标准输出修改为program2的标准输入
tr -d '\r' < abc.txt | sort > unix-file.txt


### 命令行参数 ###
echo "first arg is $1"
echo "tenth arg is ${9}"    # 超过9个，就用{}把数字括起来

### 命令执行 ###
set +x  # -x 选项显示被执行到的命令
set -x
sh -x test002.sh
bash -x test002.sh

#注意在shell中处理遍历比python中要慢很多
while read myline
do
    fid=`echo $myline |awk '{print $1}'`
    python read-redis-key.py $fids
done < filter_fid
#改为如下方式快很多
python read-redis-key.py < filter_fid 2> err.msg
#python中按行读取文件,for line in sys.stdin:
