# Imdb downloader
Download database files from imdb and process it

## Prerequisites
* curl	 *-to download the files*
* gzip	*-to unzip the files*
* mysqlimport	*-to upload the files to your database*

* Download the repository, no need to install

## What is it doing
* new.sh

contains an example of using (imdb_downloader.sh, converter.sh and csv_uploader.sh) to download, convert, and upload the imdb database
* update.sh

contains an example of using (imdb_downloader.sh, converter.sh, differences.sh and csv_uploader.sh) to download, convert, and update the imdb database
* imdb_downloader.sh

download the datafile(s) from the imdb website, and unzip the file(s). (zipped files will be deleted)
* converter.sh

convert a file to .csv format and create a .coloumninfo file which contains only the first row of the file (so you can check the table coloumns, without opening the big file). (original .tsv file will be deleted)
* differences.sh

compare two .csv file, create one .sql file with the help of .coloumninfo file
* csv_uploader.sh

upload a .csv file to your database table. (the table must be exists, and the .csv file's name must be the database table name)

## How does it work

### new.sh :
```
./new.sh
```
* It download the: name.basics.tsv.gz, title.akas.tsv.gz, title.basics.tsv.gz, title.crew.tsv.gz, title.ratings.tsv.gz files to a download directory
* Then (in this order) convert them to: imdb_names.csv, imdb_region_movies.csv, imdb_movies.csv, imdb_makers.csv, imdb_ratings.csv
* Create the imdb_names.coloumninfo, imdb_region_movies.coloumninfo, imdb_movies.coloumninfo, imdb_makers.coloumninfo, imdb_ratings.coloumninfo files
* Delete the name.basics.tsv.gz, title.akas.tsv.gz, title.basics.tsv.gz, title.crew.tsv.gz, title.ratings.tsv.gz files
* MANUAL ONE TIME STEP: Create DB tables (imdb_names,imdb_region_movies,imdb_movies,imdb_makers,imdb_ratings) (commented part)
* Upload the data from the .csv files to the database

### update.sh :
```
./update.sh
```
* It download the: name.basics.tsv.gz, title.akas.tsv.gz, title.basics.tsv.gz, title.crew.tsv.gz, title.ratings.tsv.gz files to a download2 directory
* Then (in this order) convert them to: imdb_names.csv, imdb_region_movies.csv, imdb_movies.csv, imdb_makers.csv, imdb_ratings.csv
* Create the imdb_names.coloumninfo, imdb_region_movies.coloumninfo, imdb_movies.coloumninfo, imdb_makers.coloumninfo, imdb_ratings.coloumninfo files
* Delete the name.basics.tsv.gz, title.akas.tsv.gz, title.basics.tsv.gz, title.crew.tsv.gz, title.ratings.tsv.gz files
* Check the differences between the current and previous .csv files (in the download and download2 directories), creating .sql files
* Delete the download directory
* Rename the download2 directory to download directory
* Upload the data from the .sql files to the database

### imdb_downloader.sh :
```
./imdb_downloader.sh [folder path] (filename)
```
* [folder path] - Is the folder path where you want to download the database files (e.g. C:\Program Files\Tablet). It's required
* (filename) - If you want to download only one file from the IMDB datafiles (e.g. name.basics.tsv.gz). It's optional. Otherwise it will download all of the datafiles
* *You can check the [datafiles here](https://datasets.imdbws.com/).*

### converter.sh :
```
./converter.sh [file] [converted name] (convert to folder)
```
* [file] - Is the file you want to convert (e.g. C:\Program Files\Tablet\name.basics.tsv). It's required
* [converted name] - Is the converted filename (e.g. names). It's required
* [convert to folder] - Is the foldername (relative to the [file] , you want to convert). It's optional, default is the directory where the [file] is.

### differences.sh :
```
./differences.sh [previous file] [current file] [coloumn data]
```
* [previous file] - Is the previous file (e.g. C:\Program Files\Tablet\name.basics.tsv). It's required
* [current file] - Is the current file (e.g. C:\Program Files\Tablet\name_current.basics.tsv). It's required
* [coloumn data] - Is the .coloumninfo file (doesn't matter if the previous, or the current file's).

### csv_uploader.sh :
```
./csv_uploader.sh [file] [database] [database username]
```
* [file] - Is the file you want to upload to your mysql database. The file must be named the table name. It's required
* [database] - The name of your database. It's required
* [database username] - Username of your [database]. It's required

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details
