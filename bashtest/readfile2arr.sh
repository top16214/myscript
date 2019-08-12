#!/bin/bash
# example showes how to read lines from a file

FILE="$HOME/down.lst"
# IFS= read -r -a arr <<< `cat $FILE`       # this only receive the 1st line.

# 方法一
# 正常方法
# IFS= 表示word split为空；read -r 表示接收方式为raw，则字符串即使有空白字符也不段句
while IFS= read -r
do
    arr+=("$REPLY")         # arr是数组，在使用前你甚至无需提前申明，直接使用则初始值为空
done < "$FILE"

# 方法二
# 失效方法
# | pipeline 表示subshell，subshell里面变量对于main shell无影响
# arr=()    # arr in main shell
# cat "$FILE" | while IFS= read -r
# do
#     echo "$REPLY"
#     arr+=("$REPLY")         # this is the arr in subshell，对于外面的arr无任何影响
# done
# ${#arr[@]} == 0, becoz arr == ()

printf "%s %d elements.\n" "array has" ${#arr[@]}

for idx in ${!arr[@]};do
    printf "%d : %s" $idx "${arr[$idx]}"
    echo
done
