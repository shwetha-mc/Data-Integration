#!/bin/bash

arch=$(arch)

if [ $arch == "x86_64" ]
then
	sqlcmd="sqlplus64"
else
	sqlcmd="sqlplus"
fi

if [ $# -eq 5 ]
then
	echo export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib:$LD_LIBRARY_PATH
	$sqlcmd $1/$2@$3/$4 @gen/exportscript.sql $5
	scp gen/data/$5.csv hpccdemo@172.23.49.205:/var/lib/HPCCSystems/mydropzone
else
	echo "This script needs to be run with the following arguments"
	echo "./oracleloader.sh username password hostname:port serviceid tablename"
fi

