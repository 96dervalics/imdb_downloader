#!/bin/bash

folderPath=$1
fileName=$2

if [ -z ${folderPath} ]
then
      echo "./imdb_downloader.sh [folderPath] (fileName)"
else
	echo "----------------- START ----------------"
	echo "------| IMDB datafile downloader |------"
	echo "----------------------------------------"
	echo "STEP #1 : Check if ${folderPath} exists"
	if [ -d ${folderPath} ]
	then
		echo "STEP #2 : ${folderPath} exists"
	else
		echo "STEP #2 : ${folderPath} doesnt exists, create folder"
		mkdir ${folderPath}
	fi

	if [ -z ${fileName} ]
	then
		echo "STEP #3 : Download all files from IMDB"
		curl -o ${folderPath}/name.basics.tsv.gz https://datasets.imdbws.com/name.basics.tsv.gz
		curl -o ${folderPath}/title.akas.tsv.gz https://datasets.imdbws.com/title.akas.tsv.gz
		curl -o ${folderPath}/title.basics.tsv.gz https://datasets.imdbws.com/title.basics.tsv.gz
		curl -o ${folderPath}/title.crew.tsv.gz https://datasets.imdbws.com/title.crew.tsv.gz
		curl -o ${folderPath}/title.episode.tsv.gz https://datasets.imdbws.com/title.episode.tsv.gz
		curl -o ${folderPath}/title.principals.tsv.gz https://datasets.imdbws.com/title.principals.tsv.gz
		curl -o ${folderPath}/title.ratings.tsv.gz https://datasets.imdbws.com/title.ratings.tsv.gz

		echo "STEP #4 : Extract all files"
		gunzip ${folderPath}/name.basics.tsv.gz
		gunzip ${folderPath}/title.akas.tsv.gz
		gunzip ${folderPath}/title.basics.tsv.gz
		gunzip ${folderPath}/title.crew.tsv.gz
		gunzip ${folderPath}/title.episode.tsv.gz
		gunzip ${folderPath}/title.principals.tsv.gz
		gunzip ${folderPath}/title.ratings.tsv.gz
	else
		echo "STEP #3 : Download ${fileName} from IMDB"
		curl -o ${folderPath}/${fileName} https://datasets.imdbws.com/${fileName}
		
		echo "STEP #4 : Extract ${fileName}"
		gunzip ${folderPath}/${fileName}
	fi
	echo "STEP #5 : Finish"
	echo "---------------------------------------"
	echo "-----| IMDB  datafile downloader |-----"
	echo "---------------- END ------------------"
fi