#!/bin/bash
# Usage: ./transfer.sh sourceDir remoteDir target
# example ./transfer.sh /dev/shm/ /mnt/WD4T/private/foto/met-art/ MetArt.com*
# will scp all MetArt.com* dirs to remote IP's /mnt/WD4T/private/foto/met-art/

echo "./transfer.sh sourceDir remoteDir target"
[[ $# = 3 ]] || exit 1


IP="10.0.0.3"
user="pi"
# remotePATH="/mnt/WD4T/private/foto/met-art/"
remotePATH=$2
prePATH=$PWD
cd $1
names=( `printf "%s " $3` )
for i in ${names[@]};do
	echo "processing $i"
	tar -c $i|pv|lz4 -B4|ssh -c aes128-ctr -o"MACs umac-64@openssh.com" $user@$IP "lz4 -d |tar -xC $remotePATH"
	if [ `echo $?` -eq 0 ];then
		rm -rf $i
	else
		echo $i transfer failed.
	fi
done

cd $prePATH

