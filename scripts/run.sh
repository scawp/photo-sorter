#!/bin/bash

#echo -n "Source folder: "
#read source

#echo "$source"



source_dir="/mnt/d/BACKUP/2GB SD/"
destintion_dir="/mnt/d/stagingPhotos/"

./find-and-log-matches.sh "$source_dir"
./generate-new-filepathnames.sh "../tmp/found-files.txt" "$destintion_dir"

#./create-new-files-and-paths.sh "../tmp/generated-filepathnames.txt"