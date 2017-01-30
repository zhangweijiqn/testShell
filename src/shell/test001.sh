#!/usr/bin/env bash
# 在第一行用 #! 告知unix使用哪个shell来执行脚本
who
who | wc -l

cat > nusers # 建立文件，使用cat复制终端的输入到nusers中
 who | wc -l
 # ctrl+D, end of file
chmod +x nusers
./nusers

cd dir;ls -lh   # ;号分隔同一行里的多条命令
cat nusers & ls -lh # &时shell将在后台执行前面的命令，即不用等到该命令完成就可以继续执行下一个命令。
