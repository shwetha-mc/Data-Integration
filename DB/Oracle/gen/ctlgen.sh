#!/bin/bash

if [ $# -eq 2 ]
then
	rm $HPCC_ORA/gen/tmp/$2.ctl
	printf "load data \n" >> $HPCC_ORA/gen/tmp/$2.ctl
	printf " infile '$HPCC_ORA/gen/data/downloads/"$1"' \n" >> $HPCC_ORA/gen/tmp/$2.ctl
	printf " into table "$2"\n" >> $HPCC_ORA/gen/tmp/$2.ctl
	printf " fields terminated by \",\" optionally enclosed by '\"' \n (" >> $HPCC_ORA/gen/tmp/$2.ctl
	tr '\n' ', ' < $HPCC_ORA/gen/tmp/colnames_$2.txt | rev | cut -c 2- | rev  >> $HPCC_ORA/gen/tmp/$2.ctl
	printf ")\n" >> $HPCC_ORA/gen/tmp/$2.ctl
else
	printf "\n ERROR: Number of arguments: Expected 2, Received "$#
fi
