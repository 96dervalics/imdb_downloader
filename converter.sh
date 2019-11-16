#!/bin/bash

file=$1
convertFolder=$2
convertedName=$3

if [ -z ${file} ] || [ -z ${convertFolder} ] || [ -z ${convertedName} ]
then
	echo "./converter.sh [file] [convert to folder] [converted name]"
else
	baseName=$(basename "$1")
	#fileExtension="${baseName##*.}"
	fileName="${baseName%.*}"

	dirName=$(dirname "$1")
	lineNumber=500000

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
	echo "STEP #4 : Get first line of the file (${dirName}/${convertFolder}/${convertedName}_coloumn_data.txt)"
	firstLineFile=$dirName/$convertFolder/$convertedName"_coloumn_data.txt"
	line=$(head -n 1 ${convertedFile})
	echo $line > $firstLineFile

	#delete first line
	#sed -i '1d' $convertedFile

	#split file
	#splittedFile=$convertedFile
	#split -l ${lineNumber} -d $convertedFile $splittedFile

	echo "STEP #5 : Finish"
fi