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

### date ###
date [options] [format]
date                    #2017年 2月 1日 星期三 10时46分00秒 CST
date +%Y%m%d            #显示年月日，20170201
date +%H%M%S            #显示小时分秒
date +%Y%m%d --date="+2 day"        #显示后两天，day或者days都可以，注意mac上date不支持-d
date +%Y%m%d -d "+2 days"           #同上
date +%Y%m%d -d "20170605 +2 days"  #某一天的后两天同上,注意-d后面的内容加引号

date "+%Y%m%d" --date="-2 day"      #显示前两天,可以是 day,month,year,week
date "+%s"              #显示时间戳（秒数），通常用于计时
date -d "1464073905025" #将时间戳转换为普通时间
# examples
current=`date -d "-1hours" "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s`
echo "current=$current, timestamp=$timeStamp"
hour_ago=`date -d "-1 hour $current" "+%Y-%m-%d %H:%M:%S"`
timeStamp_ago=`date -d "$hour_ago" +%s`
echo "hour_ago=$hour_ago, timestamp=$timeStamp_ago"

tree    #可以递归的列出目录下所有的文件，并以树状形式展现, 更多使用 tree --help 查看





