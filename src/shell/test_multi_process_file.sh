#!/usr/bin/bash
source ./config.ini
function send2hdfs_multi_process(){
    file_path=$1
    output_path=$2

    # multi_process
    tmp_fifofile="/tmp/$$.fifo"
    mkfifo $tmp_fifofile
    exec 8<>$tmp_fifofile
    rm $tmp_fifofile
    threadNum=10
    for ((i=0;i<${threadNum};i++));
    do
        echo -ne "\n" 1>&8
    done    
    for filename in `ls $file_path` 
    do
        read -u 8
        {       
            echo "deal file: $filename"
            #$hadoop_bin fs -put $filename $output_path 
            echo -ne "\n" 1>&8
        } &     
    done    
}
send2hdfs_multi_process "data_couser_tids_4mint" ""
