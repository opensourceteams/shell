#!/bin/bash
#安装远程本机ssh免密登录本机

for i in $( seq 1 4 )

do
    echo 控制台输出第台机器进行ssh免客登录操做:s$i
	
    export TEMP_S=s$i
	export TEMP_REMOTE_DIR=~/temp/id_dsa_dir
	export TEMP_PASSWORD=hadoop

	#安装远程本机ssh免密登录远程本机
	ssh  $TEMP_S rm -rf ~/.ssh
	sshpass -p $TEMP_PASSWORD ssh  $TEMP_S "ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa"
	sshpass -p $TEMP_PASSWORD ssh  $TEMP_S  "cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys"


	#安装本机ssh免密登录远程机
	sshpass -p $TEMP_PASSWORD ssh  $TEMP_S rm -rf $TEMP_REMOTE_DIR
	sshpass -p $TEMP_PASSWORD ssh  $TEMP_S "mkdir -p $TEMP_REMOTE_DIR"
	sshpass -p $TEMP_PASSWORD scp -r ~/.ssh/id_dsa.pub   $TEMP_S:$TEMP_REMOTE_DIR
	sshpass -p $TEMP_PASSWORD ssh  $TEMP_S "cat ${TEMP_REMOTE_DIR}/id_dsa.pub >> ~/.ssh/authorized_keys"

done

