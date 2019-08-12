#!/bin/bash
# 变量间接引用（indirect reference）数例

mya=1
myb=2
yourc=3
echo ${!my*}
# output: mya myb
echo
for i in `echo ${!my*}`
do 
    echo "$i = ${!i}"
    echo
done
