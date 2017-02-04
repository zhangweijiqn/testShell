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