#!/bin/bash

#TODO
#get args instead of hardcode

dir="/mnt/c/Users/rob/Documents/"

ext_array=("jpg" "jpeg" "png")
#ext_array+=("pdf")


echo "searching for ${ext_array[@]} files"

#turn array into string for regmatch "jpg|jpeg|png"
IFS='|';ext_regex="${ext_array[*]}"; unset IFS;

#option -iregex for case insensative
#matches will be written to temp file
count_found_files=$(find "$dir" -regextype posix-egrep -regex '.*\.('"$ext_regex"')$' | tee "../tmp/found-files.txt" | wc -l)

echo "$count_found_files files found and written to ../tmp/found-files.txt"

#exit with success if files found, else error
if (( count_found_files > 0 )); then
  exit 0
else
  exit 1
fi