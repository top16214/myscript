#!/bin/bash

# determine str is dir
function isDir(){
    if [[ "$1" =~ "#" ]];then
        echo "Y"
    else
        echo "N"
    fi

}


function md(){
    DIRNAME="${1:1}"

    if [ -e "$DIRNAME" ];then
        rm -rf "$DIRNAME"
    fi

    if [ ${#DIRNAME} -ne 0 ];then
        mkdir "$DIRNAME"
        if [ $? -eq 0 ];then
            echo -e "\n\n$DIRNAME has been created!"
            pushd "$DIRNAME"                # 当前目录进栈
        else
            echo -e "\n\n$DIRNAME cannot been created!"
            exit -1
        fi
    fi

}


function download(){
    job_num=${#nameArray[@]}   # 任务总数
    local line

    for ((i=0;i<${job_num};i++));do # 任务数量
        # 一个read -u6命令执行一次，就从fd6中减去一个回车符，然后向下执行，
        # fd6中没有回车符的时候，就停在这了，从而实现了线程数量控制
        read -u6

        line=${nameArray[$i]}
        #可以把具体的需要执行的命令封装成一个函数
        {

            # down.lst里面保存的是thumb小图地址，需要处理掉后缀才是大图地址
            fullname=${line/%.thumb.jpg}
            ext=${fullname##*.}
            prefix=$(printf "%03d" $i)
            curl -o "${prefix}.${ext}" --silent ${fullname}
            # printf "\nSave name:%s\nOriginal names:%s\n" "${prefix}.${ext}" ${fullname}
            if [ $? -eq 0 ];then
                printf "\n%s \e[32mOK\e[0m" "${prefix}.${ext}"
            else
                printf "\n%s \e[32mFailed\e[0m" "${prefix}.${ext}"
            fi

            echo >&6 # 当进程结束以后，再向fd6中加上一个回车符，即补上了read -u6减去的那个

        }&

    done

    wait
    echo
    popd


}


function flush(){
    download
}


function main(){

    FILE="./down.lst"
    [ -e $FILE ]||exit 1

    tmp_fifofile="/tmp/$$.fifo"
    mkfifo $tmp_fifofile        # 新建一个fifo类型的文件
    exec 6<>$tmp_fifofile       # 将fd6指向fifo类型
    rm $tmp_fifofile            #删也可以


    thread_num=5  # 最大可同时执行线程数量
    #根据线程总数量设置令牌个数
    for ((i=0;i<${thread_num};i++));do
        echo
    done >&6


    while IFS="" read -r line
    do

        if [ $(isDir "$line") = "Y" ];then
            # echo "当前目录：$line"
            if [ ${#nameArray[@]} -eq 0 ];then
                echo "...Start..."
            else
                download
            fi

            nameArray=()

            md "$line"

            continue

        fi

        nameArray+=("$line")

    done < $FILE


    flush

    exec 6>&- # 关闭fd6
    echo "over"

}



main
