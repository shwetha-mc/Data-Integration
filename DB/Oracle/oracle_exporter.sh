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
	if [ -t 0 ]
		then
			filename=$1
			user=$2
			pass=$3
			host=$4
			service=$5
			loc=$6
			tablename=$7
		else
			read filename user pw host service loc tablename
	fi
	if [ $loc == "nolocal" ]
		then
			scp hpccdemo@192.168.13.130:/var/lib/HPCCSystems/mydropzone/$filename $HPCC_ORA/gen/data/downloads/
			
		else
			cp /var/lib/HPCCSystems/mydropzone/$filename $HPCC_ORA/gen/data/downloads/
	fi
	#generate control file
	sh $HPCC_ORA/./gen/getcolumns.sh $tablename
	$sqlcmd $user/$pass@$host/$service @$HPCC_ORA/gen/tmp/exportscript.sql
	sh $HPCC_ORA/./gen/ctlgen.sh $filename $tablename
	#execute sqlldr command but not before setting ORACLE_HOME and ORACLE_BASE
	$ORACLE_HOME/bin/./sqlldr $user/$pass@$host/$service control=$HPCC_ORA/gen/tmp/$tablename.ctl log=$HPCC_ORA/gen/logs/$tablename.log bad=$HPCC_ORA/gen/logs/$tablename.bad
	
else
	echo "./oracle_exporter.sh filename username password hostname:port serviceid local/nolocal tablename"
fi
