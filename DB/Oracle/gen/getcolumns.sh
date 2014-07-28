#!/bin/bash


if [ $# -eq 1 ]
then
	rm gen/tmp/exportscript.sql
	rm gen/tmp/colnames_$1.txt
	cat gen/template >> gen/tmp/exportscript.sql
	printf "SPOOL gen/tmp/colnames_"$1".txt REPLACE \n" >> gen/tmp/exportscript.sql
	printf "select column_name from USER_TAB_COLUMNS WHERE table_name = UPPER('"$1"');" >> gen/tmp/exportscript.sql
	printf "\nSPOOL OFF \nEXIT" >> gen/tmp/exportscript.sql
	
else
	printf "\n ERROR: Number of arguments: Expected 1, Received "$#
fi
