#!/bin/bash

file=$1
dataBase=$2
dbUser=$3

if [ -z ${file} ] || [ -z ${dataBase} ] || [ -z ${dbUser} ]
then
    echo "./csv_uploader.sh [file] [database] [database username]"
else
	echo "STEP #1 : Import ${file} to mysql table"
	mysqlimport --fields-terminated-by=, --ignore-lines=1 --local -u ${dbUser} -p ${dataBase} ${file}

	echo "STEP #2 : Finish"
fi