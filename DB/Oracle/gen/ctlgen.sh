#!/bin/bash

if [ $# -eq 2 ]
then
	rm gen/tmp/$2.ctl
	printf "load data \n" >> gen/tmp/$2.ctl
	printf " infile 'gen/data/downloads/"$1"' \n" >> gen/tmp/$2.ctl
	printf " into table "$2"\n" >> gen/tmp/$2.ctl
	printf " fields terminated by \",\" optionally enclosed by '\"' \n (" >> gen/tmp/$2.ctl
	tr '\n' ', ' < gen/tmp/colnames_$2.txt | rev | cut -c 2- | rev  >> gen/tmp/$2.ctl
	printf ")\n" >> gen/tmp/$2.ctl
else
	printf "\n ERROR: Number of arguments: Expected 2, Received "$#
fi