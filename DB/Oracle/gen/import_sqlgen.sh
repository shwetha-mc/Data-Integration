#!/bin/bash


printf "SPOOL gen/data/uploads/"$1.csv" REPLACE \n" >> gen/tmp/importscript.sql

if [ $# -eq 2 ]
then
	cat $2 >> gen/tmp/importscript.sql
else
	printf "SELECT * FROM "$1" \n" >> gen/tmp/importscript.sql	
	
fi
printf "SPOOL OFF \n" >> gen/tmp/importscript.sql
