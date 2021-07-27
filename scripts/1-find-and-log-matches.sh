#!/bin/bash

#TODO
#get args instead of hardcode

#dir="/mnt/d/BACKUP/2GB SD/"
dir=$1

run_id=$2

#check "source_dir" has been entered (ths only check for NULL)
if [ -z "$dir" ]; then
  echo "No Destination Dir, qutting."
  exit 1;
fi

#check "run_id" has been entered
if [ -z "$run_id" ]; then
  run_id=$(date +"%s%3N")
fi

ext_array=("jpg" "jpeg" "png" "bmp" "raw" "gif")
#ext_array+=("pdf")

echo "searching for ${ext_array[@]} files"

#turn array into string for regmatch "jpg|jpeg|png"
IFS='|';ext_regex="${ext_array[*]}"; unset IFS;

#option -iregex for case insensative
#matches will be written to temp file
count_found_files=$(find "$dir" -regextype posix-egrep -regex '.*\.('"$ext_regex"')$' | tee "../tmp/1-find-and-log-matches-$run_id.log" | wc -l)

echo "$count_found_files files found and written to ../tmp/1-find-and-log-matches-$run_id.log"

#exit with success if files found, else error
if (( count_found_files > 0 )); then
  exit 0;
else
  exit 1;
fi