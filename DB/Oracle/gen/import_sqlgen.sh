#!/bin/bash


printf "SPOOL "$1$2.csv" REPLACE \n" >> $HPCC_ORA/gen/tmp/importscript.sql

if [ $# -eq 3 ]
then
	cat $3 >> $HPCC_ORA/gen/tmp/importscript.sql
else
	printf "SELECT * FROM "$2" \n" >> $HPCC_ORA/gen/tmp/importscript.sql	
	
fi
printf "SPOOL OFF \n" >> $HPCC_ORA/gen/tmp/importscript.sql
