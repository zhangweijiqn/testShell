#!/bin/bash
# hdfs file is named by date such like '20170606' and local directory 'additional' should kept the same to hdfs directory
# file will be overdue according to interv configure

interv=7
date1=`date +%Y%m%d -d "-${interv} day"`
t1=`date -d "$date1" +%s`   # trans date to timestamp

# get file names from hdfs
hadoop fs -ls /***/tids_additional | awk -F'\/' '{print $NF}' > file_list
i=0
while read myline
do
    echo "check hdfs file $i=$myline"
    if [ $i -eq 0 ];then
        ((i++))
        continue    # skip first row
    fi
    files[$i]=$myline
    ((i++))
done < file_lists

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
            hadoop fs -get /***/tids_additional/$file ../additional
            echo "download tids file: $file"
            ((i++))
        fi
    else
        hadoop fs -mv /***/tids_additional/$file /***/tids_additional_histi/
        echo "move $file to history"
    fi
done

if [ $?==0 ];then
    echo "add hdfs additional tid files ($i) success!"
else
    echo "add other tids failed!"
fi


# check if hdfs part already produced and if the row count is normal
function check_hdfs_files_is_exist() {
    IS_EXIST=0
    FILE=$1
    echo ${FILE}
    for i in {1..240}
    do
        ${HADOOP} fs -test -e "${FILE}"
        if [ $? -eq 0 ]; then
            ${HADOOP} fs -test -e ${FILE}/_temporary
            if [ $? -ne 0 ]; then
                echo "`date`: HDFS File exists[$?]"
                return 0
            fi
            echo "`date`: wait for  file: ${FILE}..."
            sleep 1.0m
        else
            echo "`date`: wait for  file: ${FILE}..."
            sleep 1.0m
        fi
    done
    return 1
}

hdfs_part_file=/.../$day
check_hdfs_files_is_exist $hdfs_part_file
if [ $? -ne 0 ]; then
    msg="hdfs path ... depended on doesn't exist whole day!"
    /bin/gsmsend-script 13591767493@$msg
    return 1
fi

# check the result is normal
tids_num=`wc -l data/stat_data_alltids.${day} | awk '{print $1}'`
if [ $tids_num -lt 10000 ];then
    /bin/gsmsend-script 135xxx@"[Warning!] stat_data_alltids.${day} is abnormal!"
fi
