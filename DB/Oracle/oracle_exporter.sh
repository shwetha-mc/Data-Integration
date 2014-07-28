#!/bin/bash

arch=$(arch)

if [ $arch == "x86_64" ]
then
	sqlcmd="sqlplus64"
else
	sqlcmd="sqlplus"
fi


if [ $# -ge 4 ]
then
	filename=$1
	user=$2
	pwd=$3
	host=$4
	service=$5
	tablename=$6
	scp hpccdemo@192.168.13.130:/var/lib/HPCCSystems/mydropzone/$filename gen/data/downloads
	#generate control file
	sh ./gen/getcolumns.sh $tablename
	$sqlcmd $user/$pwd@$host/$service @gen/tmp/exportscript.sql
	sh ./gen/ctlgen.sh $filename $tablename
	#execute sqlldr command but not before setting ORACLE_HOME and ORACLE_BASE
	$ORACLE_HOME/bin/./sqlldr $user/$pwd@$host/$service control=gen/tmp/$tablename.ctl log=gen/logs/$tablename.log bad=gen/logs/$tablename.bad
	
else
	echo "./oracle_exporter.sh filename username password hostname:port serviceid tablename"
fi