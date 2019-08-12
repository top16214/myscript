#!/bin/bash
# change filename like 1(5).mp4 to 5.mp4

# h='
# usage:  ./changename.sh [ext] [path]
# ext - supports jpg,mp4. default mp4
# path - current directory by default
# '

# echo -e "$h"
read -p "Enter the file ext: jpg or mp4(default): " ext
IFS=
read -p "Enter the directory: (current dir by default): " -r dirname
ext=${ext:-"mp4"}
dirname=${dirname:-"$PWD"}

[ -d "$dirname" ] && pushd "$dirname"

# pat=""
arr_names=( *.$ext )
for name in "${arr_names[@]}"
do
    num=`echo "$name" |cut -d "(" -f2 | cut -d ")" -f1`
    newName=`printf "%02d.mp4" ${num}`
    mv "$name" "$newName"
done

popd
