#!/bin/bash

#DOWNLOAD DATA
sh ./imdb_downloader.sh ./download name.basics.tsv.gz
sh ./imdb_downloader.sh ./download title.akas.tsv.gz
sh ./imdb_downloader.sh ./download title.basics.tsv.gz
sh ./imdb_downloader.sh ./download title.crew.tsv.gz
sh ./imdb_downloader.sh ./download title.ratings.tsv.gz

#CONVERT DATA
sh ./converter.sh ./download/name.basics.tsv imdb_names
sh ./converter.sh ./download/title.akas.tsv imdb_region_movies
sh ./converter.sh ./download/title.basics.tsv imdb_movies
sh ./converter.sh ./download/title.crew.tsv imdb_makers
sh ./converter.sh ./download/title.ratings.tsv imdb_ratings

#CREATE DB TABLES
#create table imdb_names (nconst varchar(20) PRIMARY KEY, primaryName varchar(50), birthYear year, deathYear year, primaryProfession longtext, knownForTitles longtext);
#create table imdb_region_movies (titleId varchar(20),ordering int(3), title varchar(255), region varchar(5), types text, attributes longtext, isOriginalTitle boolean);
#create table imdb_movies (tconst varchar(20) PRIMARY KEY, titleType varchar(20), primaryTitle varchar(255), originalTitle varchar(255), isAdult boolean, startYear year, endYear year, runtimeMinutes int(5), genres text);
#create table imdb_makers (tconst varchar(20) PRIMARY KEY, directors text, writers text);
#create table imdb_ratings (tconst varchar(20) PRIMARY KEY, averageRating varchar(5), numVotes int(10));

#UPLOAD DATA TO DB TABLES
sh ./csv_uploader.sh ./download/imdb_names.csv vaszonleso root
sh ./csv_uploader.sh ./download/imdb_region_movies.csv vaszonleso root
sh ./csv_uploader.sh ./download/imdb_movies.csv vaszonleso root
sh ./csv_uploader.sh ./download/imdb_makers.csv vaszonleso root
sh ./csv_uploader.sh ./download/imdb_ratings.csv vaszonleso root