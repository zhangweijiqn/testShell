#!/usr/bin/env bash
tempfifo=$$.fifo        # $$表示当前执行文件的PID
# -----------------------------

tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile
exec 6<>$tmp_fifofile
rm $tmp_fifofile
threadNum=10
loopNum=20

for ((i=0;i<${threadNum};i++));
do
    echo -ne "\n" 1>&6
done

for ((i=0;i<${loopNum};i++));
do
        read -u 6
        {
            echo "abc${i}"
            python test.py $i
            echo -ne "\n" 1>&6
         }&
done
wait
exec 6>&-
echo "done!!!"