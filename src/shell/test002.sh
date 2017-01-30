#!/bin/ bash

### 变量 ###
variable1=abc #（1）字符串中间没有空格时可以不加双引号； （2）等号前后不要加空格，否则会报错
variable2=" def ghi"
echo $variable2     #变量引用时前面要加$,或者${}来引用
echo ${variable2}
echo "$variable1,$variable2"