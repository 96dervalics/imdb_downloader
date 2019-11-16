#!/bin/bash

#DOWNLOAD DATA
sh ./imdb_downloader.sh ./download2 name.basics.tsv.gz
sh ./imdb_downloader.sh ./download2 title.akas.tsv.gz
sh ./imdb_downloader.sh ./download2 title.basics.tsv.gz
sh ./imdb_downloader.sh ./download2 title.crew.tsv.gz
sh ./imdb_downloader.sh ./download2 title.ratings.tsv.gz

#CONVERT DATA
sh ./converter.sh ./download2/name.basics.tsv imdb_names
sh ./converter.sh ./download2/title.akas.tsv imdb_region_movies
sh ./converter.sh ./download2/title.basics.tsv imdb_movies
sh ./converter.sh ./download2/title.crew.tsv imdb_makers
sh ./converter.sh ./download2/title.ratings.tsv imdb_ratings

#CHECK DIFFERENCES
sh ./differences.sh ./download/imdb_names.csv ./download2/imdb_names.csv ./download2/imdb_names.coloumninfo
sh ./differences.sh ./download/imdb_region_movies.csv ./download2/imdb_region_movies.csv ./download2/imdb_region_movies.coloumninfo
sh ./differences.sh ./download/imdb_movies.csv ./download2/imdb_movies.csv ./download2/imdb_movies.coloumninfo
sh ./differences.sh ./download/imdb_makers.csv ./download2/imdb_makers.csv ./download2/imdb_makers.coloumninfo
sh ./differences.sh ./download/imdb_ratings.csv ./download2/imdb_ratings.csv ./download2/imdb_ratings.coloumninfo

#DELETE PREVIOUS DIRECTORY
rm -r download/

#RENAME CURRENT DIRECTORY
mv download2 download

#UPDATE DATA TO DB TABLES
sh ./csv_uploader.sh ./download/imdb_names.sql vaszonleso root
sh ./csv_uploader.sh ./download/imdb_region_movies.sql vaszonleso root
sh ./csv_uploader.sh ./download/imdb_movies.sql vaszonleso root
sh ./csv_uploader.sh ./download/imdb_makers.sql vaszonleso root
sh ./csv_uploader.sh ./download/imdb_ratings.sql vaszonleso root