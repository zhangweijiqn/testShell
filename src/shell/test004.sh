#!/usr/bin/env bash
### wc ###
# 计数
wc file                 #对文件统计
cat test.txt | wc -c    #计算字节数
cat test.txt | wc -l    #计算行数
cat test.txt | wc -w    #计算字数

#显示前n条记录
head -10 test.txt
sed 10q test.txt
awk 'FNR<=10' test.txt
head -n 10 test.txt
sed -e 10q test.txt

#显示后几条记录
tail -10 test.txt
tail -n 10 test.txt
tail -n 10 -f test.txt



