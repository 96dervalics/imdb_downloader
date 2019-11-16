#!/bin/bash

file=$1
coloumnData=$2

baseName=$(basename ${file})
fileName="${baseName%.*}"
dirName=$(dirname ${file})

#diff db/title.ratings.tsv download/title.ratings.tsv --speed-large-files --color=always

if [ -z ${file} ] || [ -z ${coloumnData} ]
then
    echo "./differences.sh [file] [coloumn data]"
else
	echo "STEP #1 : Put ${coloumnData} to array"
	
	IFS=',' read -r -a colData <<< $(cat $coloumnData)

	echo "STEP #2 : Create output .sql"
	fileOut="${dirName}/${fileName}.sql"
	touch ${fileOut}

	echo "STEP #3 : Read ${file}"
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
	done < ${file}

	echo "STEP #4 : Finish"
fi