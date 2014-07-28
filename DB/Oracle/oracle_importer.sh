#!/bin/bash

arch=$(arch)

if [ $arch == "x86_64" ]
then
	sqlcmd="sqlplus64"
else
	sqlcmd="sqlplus"
fi

if [ $# -ge 5 ]
then
	user=$1
	pwd=$2
	host=$3
	service=$4
	#setup the exportscript template:
	rm gen/tmp/importscript.sql
	cat gen/template >> gen/tmp/importscript.sql
	#parse the rest of the arguments as table/path
	shift 4
	echo $1
	#while there are args left
	while [ "$1" ]
	do 
	exp="$1"
	table=${exp%,*}
	pat=${exp#*,}
	sh ./gen/import_sqlgen.sh $table $pat
	shift
	done
	printf 'EXIT' >> gen/tmp/importscript.sql
	$sqlcmd $user/$pwd@$host/$service @gen/tmp/importscript.sql
	
	scp -r gen/data/uploads/* hpccdemo@192.168.13.130:/var/lib/HPCCSystems/mydropzone/
else
	echo "This script needs to be run with the following arguments"
	echo "./oracleloader.sh username password hostname:port serviceid tablename1,path1 tablename2,path2 ..."
fi

