#!/bin/bash

FILE="$HOME/pwlist.txt"
read -r -a arr <<< `cat $FILE`
printf "%s%d" "array has"
for i in ${arr[@]};do
    echo $i
done
