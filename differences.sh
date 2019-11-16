#!/bin/bash

prevFile=$1
currFile=$2
coloumnData=$3

baseName=$(basename ${currFile})
fileName="${baseName%.*}"
dirName=$(dirname ${currFile})

if [ -z ${prevFile} ] || [ -z ${currFile} ] || [ -z ${coloumnData} ]
then
    echo "./differences.sh [previous file] [current file] [coloumn data]"
else
	echo "---------------- START ----------------"
	echo "-----| IMDB datafile differences |-----"
	echo "---------------------------------------"

	differences="${dirName}/${fileName}.differences"
	echo "STEP #1 : Create ${differences}"
	diff ${prevFile} ${currFile} --speed-large-files > ${differences}

	echo "STEP #2 : Put ${coloumnData} to array"
	IFS=',' read -r -a colData <<< $(cat $coloumnData)

	fileOut="${dirName}/${fileName}.sql"
	echo "STEP #3 : Create ${fileOut}"
	touch ${fileOut}

	echo "STEP #4 : Read ${differences}"
	while read row; 
	do
		data=${row:2}
		if [ ${row:0:1} == "<" ]
		then 
			sqlDelete="DELETE FROM ${fileName} WHERE "
			
			index=0
			for i in $(echo $data | sed "s/,/ /g")
			do
				if [ $(expr $index + 1) -ne ${#colData[@]} ]
				then
					sqlDelete=${sqlDelete}"${colData[${index}]} = '${i}' AND "
					index=$(expr $index + 1 )
				else
					sqlDelete=${sqlDelete}"${colData[${index}]} = '${i}';"
				fi
			done
			echo ${sqlDelete} >> ${fileOut}
			
		elif [ ${row:0:1} == ">" ]
		then 
			echo "INSERT INTO ${fileName} VALUES (${data});" >> ${fileOut}
		fi
	done < ${differences}
	rm ${differences}

	echo "STEP #5 : Finish"
	echo "---------------------------------------"
	echo "-----| IMDB datafile differences |-----"
	echo "---------------- END ------------------"
fi