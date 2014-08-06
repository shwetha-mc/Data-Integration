#!/bin/bash


if [ $# -eq 1 ]
then
	rm $HPCC_ORA/gen/tmp/exportscript.sql
	rm $HPCC_ORA/gen/tmp/colnames_$1.txt
	cat $HPCC_ORA/gen/template >> $HPCC_ORA/gen/tmp/exportscript.sql
	printf "SPOOL gen/tmp/colnames_"$1".txt REPLACE \n" >> $HPCC_ORA/gen/tmp/exportscript.sql
	printf "select column_name from USER_TAB_COLUMNS WHERE table_name = UPPER('"$1"');" >> $HPCC_ORA/gen/tmp/exportscript.sql
	printf "\nSPOOL OFF \nEXIT" >> $HPCC_ORA/gen/tmp/exportscript.sql
	
else
	printf "\n ERROR: Number of arguments: Expected 1, Received "$#
fi
