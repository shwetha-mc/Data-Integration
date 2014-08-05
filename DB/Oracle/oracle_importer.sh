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
	pass=$2
	host=$3
	service=$4

	if [ $5 == "nolocal" ]
		then
			finalscp=1
			spoolpath="gen/data/uploads/"
		else
			finalscp=0
			spoolpath="/var/lib/HPCCSystems/mydropzone/"
	fi
	#setup the exportscript template:
	rm gen/tmp/importscript.sql
	cat gen/template >> gen/tmp/importscript.sql
	
	#parse the rest of the arguments as table/path
	shift 5
	echo $1
	#while there are args left
	while [ "$1" ]
	do 
	exp="$1"
	table=${exp%,*}
	pat=${exp#*,}
	sh ./gen/import_sqlgen.sh $spoolpath $table $pat 
	shift
	done
	printf 'EXIT' >> gen/tmp/importscript.sql
	$sqlcmd $user/$pass@$host/$service @gen/tmp/importscript.sql
	
	if [ $finalscp -eq 1 ]
		then
			scp -r gen/data/uploads/* hpccdemo@192.168.13.130:/var/lib/HPCCSystems/mydropzone/
	fi
else
	echo "This script needs to be run with the following arguments"
	echo "./oracleloader.sh username password hostname:port serviceid local/nolocal tablename1,path1 tablename2,path2 ..."
	echo "local implies you are running this script on the Thor server (or from ECL IDE)"
	echo "nolocal implies that you are running this script from any remote machine other than the Thor server, which necessitates scp"
fi

