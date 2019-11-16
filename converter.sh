#!/bin/bash

file=$1
convertedName=$2

if [ -z ${3} ]
then
	convertFolder=""
else
	convertFolder=$3
fi

if [ -z ${file} ] || [ -z ${convertedName} ]
then
	echo "./converter.sh [file] [converted name] (convert to folder)"
else
	baseName=$(basename "$1")
	fileName="${baseName%.*}"

	dirName=$(dirname "$1")
	lineNumber=500000

	echo "----------------- START ----------------"
	echo "------| IMDB  datafile converter |------"
	echo "----------------------------------------"
	#create directory
	echo "STEP #1 : Check if ${dirName}/${convertFolder} exists"
	if [ -d ${dirName}/${convertFolder} ]
	then
		echo "STEP #2 : ${dirName}/${convertFolder} exists"
	else
		echo "STEP #2 : ${dirName}/${convertFolder} doesnt exists, create folder"
		mkdir ${dirName}/${convertFolder}
	fi

	#convert tabs to commas
	echo "STEP #3 : Convert file to ${dirName}/${convertFolder}/${convertedName}.csv"
	convertedFile=$dirName/$convertFolder/$convertedName".csv"
	sed 's/\t/,/g' $file > $convertedFile

	#get first line
	echo "STEP #4 : Get first line of the file (${dirName}/${convertFolder}/${convertedName}.coloumninfo)"
	firstLineFile=$dirName/$convertFolder/$convertedName".coloumninfo"
	line=$(head -n 1 ${convertedFile})
	echo $line > $firstLineFile

	echo "STEP #5 : Remove ${file}"
	rm ${file}

	echo "STEP #6 : Finish"
	echo "----------------------------------------"
	echo "------| IMDB  datafile converter |------"
	echo "----------------- END ------------------"
fi