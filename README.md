# Imdb downloader
Download database files from imdb and process it

## Prerequisites
* curl	 *-to download the files*
* gzip	*-to unzip the files*
* mysqlimport	*-to upload the files to your database*

## Installing

Download the repository, no need to install

## What is it doing

* imdb_downloader.sh - download the datafile(s) from the imdb website, and unzip the file(s).
* converter.sh - convert a file to .csv format and create a .txt file which contains only the first row of the file (so you can check the table coloumns, without opening a big file).
* csv_uploader.sh - upload a .csv file to your database table. (the table must be exists, and the .csv file's name must be the database table name)

## How does it work

### imdb_downloader.sh :

* You run the script:
```
./imdb_downloader.sh [folder path] (filename)
```
* [folder path] - Is the folder path where you want to download the database files (e.g. C:\Program Files\Tablet). It's required
* (filename) - If you want to download only one file from the IMDB datafiles (e.g. name.basics.tsv.gz). It's optional. Otherwise it will download all of the datafiles
* *You can check the [datafiles here](https://datasets.imdbws.com/).*

### converter.sh :

* You run the script:
```
./converter.sh [file] [converted name] (convert to folder)
```
* [file] - Is the file you want to convert (e.g. C:\Program Files\Tablet\name.basics.tsv). It's require
* [converted name] - Is the converted filename (e.g. names). It's required
* [convert to folder] - Is the foldername (relative to the [file] , you want to convert). It's optional, default is the directory where the [file] is.

### csv_uploader.sh :

* You run the script:
```
./csv_uploader.sh [file] [database] [database username]
```
* [file] - Is the file you want to upload to your mysql database. The file must be named the table name. It's required
* [database] - The name of your database. It's required
* [database username] - Username of your [database]. It's required

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
