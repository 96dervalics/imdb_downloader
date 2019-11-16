#!/bin/bash

file=$1
dataBase=$2
dbUser=$3

if [ -z ${file} ] || [ -z ${dataBase} ] || [ -z ${dbUser} ]
then
    echo "./csv_uploader.sh [file] [database] [database username]"
else
	echo "---------------- START ----------------"
	echo "------| IMDB  datafile uploader |------"
	echo "---------------------------------------"
	echo "STEP #1 : Check if ${file} is empty"
	if [ -s ${file} ]
	then
		echo "STEP #2 : Import ${file} to mysql table"
		mysqlimport --fields-terminated-by=, --ignore-lines=1 --local -u ${dbUser} -p ${dataBase} ${file}
	else
		echo "STEP #2 : ${file} is empty, mysqlimport not necessary"
	fi
	echo "STEP #3 : Deleting ${file}"
	rm ${file}
	echo "STEP #4 : Finish"
	echo "---------------------------------------"
	echo "------| IMDB  datafile uploader |------"
	echo "---------------- END ------------------"
fi