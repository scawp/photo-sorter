#!/bin/bash

source_dir=$1
run_id=$2

#check "source_dir" has been entered or die
if [ -z "$source_dir" ]; then
  echo "Source Directory is Null, qutting."
  exit 1;
elif [ ! -d "$source_dir" ]; then
  echo "Source Directory doesn't exist, qutting."
  exit 1;
fi

#check "run_id" has been entered or create one
if [ -z "$run_id" ]; then
  run_id=$(date +"%s%3N")
fi

#array of files to seach for. take as arg or create config?
#set up vars
tmp_dir="$(dirname $(dirname $(realpath "$0")))/tmp/"

ext_array=("jpg" "jpeg" "png" "bmp" "raw" "gif")

echo "searching for ${ext_array[@]} files" 

#turn array into string for regmatch "jpg|jpeg|png"
IFS='|';ext_regex="${ext_array[*]}"; unset IFS;

#option -iregex for case insensative
#matches will be written to temp file
count_found_files=$(find "$source_dir" -regextype posix-egrep -regex '.*\.('"$ext_regex"')$' | tee "$tmp_dir/1-find-and-log-matches-$run_id.log" | wc -l)

echo "$count_found_files files found and written to $tmp_dir/1-find-and-log-matches-$run_id.log"

#exit with success if files found, else error
if (( count_found_files > 0 )); then
  exit 0;
else
  exit 1;
fi