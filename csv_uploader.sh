#!/bin/bash

file=$1
dbUser="root"
dbPassword=""
dataBase="vaszonleso"

if [ -z ${file} ]
then
    echo "./csv_uploader.sh [file]"
else
	echo "STEP #1 : Import ${file} to mysql table"
	mysqlimport --fields-terminated-by=, --ignore-lines=1 --local -u root -p vaszonleso ${file}

	echo "STEP #2 : Finish"
fi