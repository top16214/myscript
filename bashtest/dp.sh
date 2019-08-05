#!/bin/bash
# 直接down，不测试url是否存在，这能加快下载速度
# using curl to download some URLs from the local downlist file.
# one URL in a line.
# 本小程序专门针对JKF图库下载，需要结合chrome里面下图插件fatkun得到图片下载地址，
# 保存到down.lst，然后通过本程序把大图扣下来
# usage: ./dp.sh 11 ["myDirName"]   删除"*.thumb.jpg"
# or ./dp.sh 0 ["myDirName"]        不删除后缀



# down.lst里面保存的是thumb小图地址，需要处理掉后缀才是大图地址
FILE="./down.lst"

test -f $FILE || exit 1

# MYPATH=$1 if $1 is available, if $1 is null, set MYPATH="./"
MYPATH=${2:-"./"}
if [ "$MYPATH" !=  "./" ];then
    mkdir "$MYPATH"
fi

idx=0
for url in $(cat $FILE)
do
    # 计算文件名总共字符数
    num=$(echo "$url"|wc -c)
    # 文件名最后部分为".thumb.jpg"，共11个字节，需要删去
    num=$[num-$1]
    newName=$(echo "$url"|cut -c -$num)
    prefix=$(printf "%03d" $idx)
    curl -o "${MYPATH}/${prefix}.jpg" --silent "$newName"
    printf "\n%s ---> %s" "$newName" "${prefix}.jpg"
    (( idx++ ))
done

echo -e "\n\nTotal $idx pics downloaded.\n"
