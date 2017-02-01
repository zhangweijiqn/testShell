#!/usr/bin/env bash
#存放系统运行的的调度程序的crontab文件一般位于/etc/下,每个用户都会生成一个一个自己的crontab文件，一般位于/var/spool/cron目录下，文件名以用户名命名(需要用户权限)#
more /etc/crontab
sudo ls /var/spool/cron/crontabs/

crontab -e                      #编辑当前用户的定时任务（等价于直接vim上面的文件）
crontab -r                      #删除当前用户的crontab文件
crontab -l                      #查看当前用户的定时任务

#sudo vim /var/spool/cron/crontabs/zhangwj
crontab -e
# 04 21 * * 1-6 /usr/bin/python ~/kq2.py >> ~/kq.log 2>&1

ps -ef | grep cron              #查看服务是否已经运行用

# crontab文件的格式#
# Minute Hout Day month week cmd.
M                               # 分钟（0-59）。
H                               #小时（0-23）。
D                               #天（1-31）。
m                               # 月（1-12）。
d                               # 一星期内的天（0~6，0为星期天）。
cmd                             #要运行的程序，程序被送入sh执行，这个shell只有USER,HOME,SHELL这三个环境变量,cmd中路径要使用绝对路径

#crontab记录日志,修改rsyslog
sudo vim /etc/rsyslog.d/50-default.conf
cron.* /var/log/cron.log        #将cron前面的注释符去掉

04 21 * * 1-6 sh kq.sh
python ~/kq2.py >> ~/kq.log 2>&1
05 21 * * 1-6 sh ~/kq.sh >> ~/kq.log 2>&1