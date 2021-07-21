#!/bin/bash

#echo -n "Source folder: "
#read source

#echo "$source"


#should add these to arg list for run.sh
#/mnt/c/Users/rob/Documents/Randon SD 2020-07
#source_dir="/mnt/c/Users/rob/Documents/Randon SD 2020-07"
source_dir="/mnt/c/Users/rob/Pictures/crap from z3/WhatsApp Images"
destintion_dir="/mnt/p/photos/"

./find-and-log-matches.sh "$source_dir"
./generate-new-filepathnames-from-name.sh "../tmp/found-files.txt" "$destintion_dir"

#./create-new-files-and-paths.sh "../tmp/generated-filepathnames.txt"