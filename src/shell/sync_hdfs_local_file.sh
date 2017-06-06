#!/bin/bash
# hdfs file is named by date such like '20170606' and local directory 'additional' should kept the same to hdfs directory
# file will be overdue according to interv configure

interv=7
date1=`date +%Y%m%d -d "-${interv} day"`
t1=`date -d "$date1" +%s`   # trans date to timestamp

# get file names from hdfs
hadoop fs -ls /app/ns/tieba/recommend/zwj/RUKU/tids_additional | awk -F'\/' '{print $NF}' > file_list
i=0
while read myline
do
    echo "check hdfs file $i=$myline"
    if [ $i -eq 0 ];then
        ((i++))
        continue
    fi
    files[$i]=$myline
    ((i++))
done < file_list

# get file list from local directory
dir=$(ls ../additional | awk '{print $NF}')
echo "current addition file list =$dir"

# check if hdfs file is new or is already downloaded
i=0
for file in ${files[*]}
do
    day=`date -d "$file" +%s`
    if [ $day -gt $t1 ];then                # judge if file is expired
        if [[ "${dir[@]}" =~ $file ]];then  # judge if a variable is in an array
            echo "file $file already exists!"
        else
            hadoop fs -get /app/ns/tieba/recommend/zwj/RUKU/tids_additional/$file ../additional
            echo "download tids file: $file"
            ((i++))
        fi
    else
        hadoop fs -mv /app/ns/tieba/recommend/zwj/RUKU/tids_additional/$file /app/ns/tieba/recommend/zwj/RUKU/tids_additional_histi/
        echo "move $file to history"
    fi
done

if [ $?==0 ];then
    echo "add hdfs additional tid files ($i) success!"
else
    echo "add other tids failed!"
fi

