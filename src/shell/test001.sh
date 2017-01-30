#!/usr/bin/env bash
# 在第一行用 #! 告知unix使用哪个shell来执行脚本
who
who | wc -l
cat > nusers # 建立文件，使用cat复制终端的输入到nusers中
who | wc -l
# ctrl+D, end of file
chmod +x nusers
./nusers