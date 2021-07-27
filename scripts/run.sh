#!/bin/bash

#echo -n "Source folder: "
#read source

#echo "$source"

run_id=$(date +"%s%3N")


#should add these to arg list for run.sh
source_dir="/mnt/c/Users/rob/Pictures/crap from z3/WhatsApp Images"
destintion_dir="/mnt/p/photos/"

./1-find-and-log-matches.sh "$source_dir" "$run_id"
./2a-generate-new-filepathnames-from-name.sh "../tmp/1-find-and-log-matches-$run_id.log" "$destintion_dir" "$run_id"
#./3-create-new-files-and-paths.sh "../tmp/2-generate-new-filepathnames-$run_id.log"