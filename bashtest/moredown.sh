#!/bin/bash
#down.lst文件里面，行首为#的是标题，作为目录名
#每个URL一行


FILE="./down.lst"
[ -f $FILE ]||exit 1

idx=0
while read line
do
	# 以"#"开头是标题，用来建立目录
	if [ $(echo $line|cut -c 1) = "#" ];then
		if [ $idx -ne 0 ];then
			echo -e "\nTotal \e[31m${idx}\e[39m pics downloaded.\n"
		fi
		dirname="$(echo $line|cut -c 2-)"
		mkdir "$dirname"
		if [ $? -eq 0 ];then
			echo -e "\n\n$dirname 已经建立"
		fi
		idx=0

		continue
	fi

    # down.lst里面保存的是thumb小图地址，需要处理掉后缀才是大图地址
    fullname=${line/%.thumb.jpg}
    ext="${fullname##*.}"
    prefix=$(printf "%03d" $idx)
    curl -o "${dirname}/${prefix}.${ext}" --silent ${fullname}
    printf "\n%s \e[32mOK\e[0m" "${prefix}.${ext}"
    (( idx++ ))


done < $FILE

echo
