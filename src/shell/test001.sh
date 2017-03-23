#!/usr/bin/env bash
# 在第一行用 #! 告知unix使用哪个shell来执行脚本
who
who | wc -l

cat > nusers        # 建立文件，使用cat复制终端的输入到nusers中
 who | wc -l
 # ctrl+D, end of file
chmod +x nusers
./nusers

cd dir;ls -lh       # ;号分隔同一行里的多条命令
cat nusers & ls -lh # &时shell将在后台执行前面的命令，即不用等到该命令完成就可以继续执行下一个命令。

# &                 # 加在一个命令的最后，可以把这个命令放到后台执行
# ctrl + z          # 可以将一个正在前台执行的命令放到后台，并且处于暂停状态。
# jobs -l           # 选项可显示所有任务的PID
# nohup             # 如果让程序始终在后台执行，即使关闭当前的终端也执行（之前的&做不到），这时候需要nohup。
# fg                # 将后台中的命令调至前台继续运行



insert overwrite directory "hdfs://yq01-heng-hdfs.dmop.baidu.com:54310/app/ns/tieba/sep/zwj/PbDataHour/20170323"
select a.thread_id as tid, get_json_object(param, "$.first_dir") as first_dir, get_json_object(param, "$.second_dir") as second_dir, forum_id, forum_name, get_json_object(title, "$.title") as title,
regexp_replace(get_json_object(content, "$.content"),"\n", " ") as content,create_time,uid
from pbdata a
join queryplatform.tids_new b
on ( a.thread_id=b.tid and a.command_no=1 and a.day>"20170321" and a.thread_id is not NULL );

