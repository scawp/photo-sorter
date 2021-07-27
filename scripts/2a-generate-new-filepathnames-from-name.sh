#!/bin/bash

found_files=$1

#destintion_dir="/mnt/d/stagingPhotos/"
destintion_dir=$2

run_id=$3

#check "found_files" file exists and isn't empty
if [ ! -f "$found_files" ]; then
    echo "Found file list \"$1\" doesnt exists, qutting."
    exit 1;
elif [ ! -s "$found_files" ]; then
    echo "Found file list \"$1\" is empty, qutting."
    exit 1;
fi

#check "destintion_dir" has been entered (ths only check for NULL),
if [ -z "$destintion_dir" ]; then
    echo "No Destination Dir, qutting."
    exit 1;
fi

#check "run_id" has been entered
if [ -z "$run_id" ]; then
  run_id=$(date +"%s%3N")
fi

#TODO: check if list is correct format

echo "Processing." #add stats


#purge previous temp file
true > "../tmp/2-generate-new-filepathnames-$run_id.log"

#read each line of "found_files" and generate new filename from file timestamp
while read -r line
do
  #look for ISO8601 date in name
  #TODO if no match dump into another file for later processing
  [[ "$line" =~ (20[0-2][0-9][0-1][0-9][0-3][0-9]) ]]
  date_in_filename="${BASH_REMATCH[0]}"

  if [ -z "$date_in_filename" ]; then
    #if unrecognised date format
    new_date_path="unknown-date/"
  else
    #create new path from date in filename
    new_date_path=$(date -d "$date_in_filename" +"%Y/%m-%b/")
  fi

  #get filename
  [[ "$line" =~ ^(.+\/)([^\/]+)\. ]]
  filename="${BASH_REMATCH[2]}"

  #get ext, this regex is overkill (and wrong), just need anything after last "."
  [[ $line =~ .([Jj][Pp]([Ee]|)[Gg]|png)$ ]]
  ext="${BASH_REMATCH[0]}"

  #tab delimited line of: original filepath, new path, filename, ext
  echo "$line"$'\t'"$destintion_dir""$new_date_path"$'\t'"$filename"$'\t'"$ext" >> "../tmp/2-generate-new-filepathnames-$run_id.log"

done < "$found_files"

echo "Done." #add stats

exit 0;