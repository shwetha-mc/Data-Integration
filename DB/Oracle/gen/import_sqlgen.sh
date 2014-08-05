#!/bin/bash


printf "SPOOL "$1$2.csv" REPLACE \n" >> gen/tmp/importscript.sql

if [ $# -eq 3 ]
then
	cat $3 >> gen/tmp/importscript.sql
else
	printf "SELECT * FROM "$2" \n" >> gen/tmp/importscript.sql	
	
fi
printf "SPOOL OFF \n" >> gen/tmp/importscript.sql
