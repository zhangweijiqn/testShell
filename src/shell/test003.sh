#!/usr/bin/env bash
### grep ###
### 查找， unix 支持 grep,egrep(extended-grep,支持扩展的正则表达式，会占更多资源),fgrep(fast-grep,只匹配固定字符串，速度快)
# grep [options] pattern files
# -E 使用扩展正则表达式匹配，等价于 egrep
# -F 使用固定字符串进行匹配，等价于 fgrep
# -f file 从file文件读取模式匹配，可以使用多个
# -e pattern-list 通常可以匹配多个模式，在引号中用换行字符分隔，但-开头时要用-e，可以使用多个
# -i 忽略大小写字母差异
# -l 列出匹配模式的文件名称，而不是打印匹配的行
# -v 显示不匹配的行
grep "abc" test002.sh
grep -v "abc" test002.sh    #不包含abc的
grep "^echo" test002.sh     #以echo开头的
grep "abc$" test002.sh      #以abc结尾的
grep "^abc$" test002.sh     #匹配一行内容为abc
grep "[Aa]bc" test002.sh    #匹配Abc或abc
grep "ab.*c"


### sed ###
# 替换/删除 (tr也有相同作用），通常作为管道的一部分，一次处理一行内容
# sed [options] 'command' file(s)
# sed [options] -f scriptfile file(s)
# 选择
sed -n '1,5p' test.txt  #显示1到5行,注意要-n结合p使用
sed -n '$p' test.txt    #显示最后一行
sed 5q test.txt         #显示前5行，q要求sed马上离开，不再读取其他输入，该命令等价于head -5 test.txt
# 删除，d命令
sed '5d' test.txt       #删除第五行
sed '1,5d' test.txt     #删除1到5行
sed '$d' test.txt       #删除最后一行
sed '/test/d' test.txt  #删除包含test的行
sed -n 's/hello//gp' test.txt   #将所有hello替换为空
# 替换：s命令，不论什么字符，紧跟着s命令的都被认为是新的分隔符
sed 's/hello/Hello/' test.txt           # 将hello替换为Hello，只替换第一次出现的
sed 's#hello#Hello#' test.txt           # 分隔符用#,在/作为分隔符时，如果字符串中有/用\/
sed 's/hello/Hello/g' test.txt          # g将所有出现的hello替换为Hello
sed 's/^hello/Hello/' test.txt          # 将以hello开头替换为Hello
sed -n 's/^hello/Hello/p' test.txt      # -n静默输出，p配合-n，只打印替换的行
sed -n 's/^hello/&world/p' test.txt     # &表示替换字符中被找到的部分，也就是相当于引用被找到的字符串，hello被替换为helloworld
sed -n 's/\(love\)able/\1rs/p' test.txt # love被标记为1，后面用\1引用love，所有loveable会被替换成lovers，\转义字符
sed '/hello/!s/aaa/AAA/g' test.txt      # 将没有hello的每个行里所有的aaa替换为AAA
# 多点编辑,-e
sed -e '1,5d' -e 's/hello/Hello/'       #一次替换多个，执行顺序有影响,先删除1到5行，然后将hello替换为Hello
sed -f fixup.sed test.txt > test2.txt   # 将多次替换写到文件中
# fixup.sed
# s/hello/Hello/g
# s/a/abc/g
# ...
# r(read),w(write),a(add),i(insert)
sed '/hello/w newfile.txt' test.txt     # 匹配到的写入到newfile.txt文件中
#sed '/hello/i\\-----------' test.txt     # 替换后的写入到newfile.txt文件中
# tr [options] source-char-list replace-char-list
tr "abc" "abcd"     #从标准输入中，将abc字符替换为abcd
tr -d "abc"         #-d删除，将标准输入中出现的abc删除


### cut ###
# 选择字段
# cut [options] file
cut -d , -f 1,2 test.txt    #-d 指定分隔符，-f指定选择哪些字段
cut -d ' ' -f 1,2 test.txt    #-d 指定分隔符，-f指定选择哪些字段
cut -c 1,2,3,4,5 test.txt   #按照字符，选择前5个字符


### join ###
# 连接字段,两个文件需要按照第一个字段排好序，文件中不能含有注释,默认分隔符空格或制表符
# join file1_sorted file2_sorted
sed '/^#/d' file1 | sort > file1_sorted
sed '/^#/d' file2 | sort > file2_sorted
join file1_sorted file2_sorted


### awk ###
# 处理字段/记录,默认分隔符空格或制表符
# awk 'program' file
# program: pattern { action } # awk会手下测试pattern，为真则执行action。pattern或action都可以省略
awk ' {print $1} ' test.txt     #打印第一个字段的值，{}内的未action，省略了pattern
awk '{print $0}' test.txt       #$0代表所有字段
awk 'NF>0'  test.txt            #打印非空行，默认为打印
awk 'NF>0 {print $0}' test.txt  #作用同上
awk -F, '{print $0}' test.txt   #-F指定分隔符
awk -F, -v 'OFS=\t' '{print $1,$2,$3,$4}' test.txt  #-v指定输出分隔符(默认是空格)，要显式指定列（不能$0)
awk -F, '{print $1","$2","$3","$4}' test.txt  #作用同上，在print的时候使用字符串拼接成逗号分隔符
awk -F, '{printf "%s,%s\n",$1,$2}' test.txt   #作用同上，printf输出，注意加\n


### sort ###
# 排序，默认从小到大
# sort [optons] files
sort -t, -k1,2 test.txt   #-t指定分隔符，未指定-t则以空白分隔, -k指定排序的字段，可以是多个
sort -t, -k1.2 test.txt   #可以指定从字段的第几个字符开始排序
sort -k3nr test.txt       #按照第3个字段从大到小排序，-n以整数类型比较字段
sort -k4n -k3n test.txt   #按照第4个字段，再按照第3个字段


### uniq ###
#删除重复
sort test.txt | uniq    #用于管道中，删除已经使用sort排序完成的重复记录,如果没有排序不会进行全局去重
sort test.txt | uniq -c #去重，并且计数
sort test.txt | uniq -d #仅显示重复的记录，-u可以仅显示未重复的记录
