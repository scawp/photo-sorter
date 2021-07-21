#!/bin/bash

#THIS WAS TO FIX A FUP KEEPING FOR REFERENCE

found_files="./tmp/generated-filepathnames.txt"

destintion_dir="/mnt/p/fixed-photos/"
#destintion_dir=$2

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

#TODO: check if list is correct format

echo "Processing." #add stats


#purge previous temp file
true > "./tmp/fixed-filepathnames2.txt"

declare -A processedFiles
i=0

#read each line of "found_files" and generate new filename from file timestamp
while read -r line
do
  #0 original path, 1 destination dir, 2 new filename, 4 extention, 5 timestamp
  IFS=$'\t'; column=($line); unset IFS; #dont do "$line" damn you shellcheck
  
  #look for ISO8601
  #TODO if no match dump into another file for later processing
  [[ "${column[0]}" =~ (20[0-2][0-9][0-1][0-9][0-3][0-9]) ]]
  fixedtimestamp="${BASH_REMATCH[0]}"

  [[ "${column[0]}" =~ ^(.+\/)([^\/]+)\. ]]
  og_filename="${BASH_REMATCH[2]}"

  original_filename=${column[2]}

  ext="${column[3]}"

  #echo $original_filename"= "${processedFiles[$original_filename]}
  if [ "${processedFiles[$original_filename$ext]}" = "bum" ]; then
    ((i++))
    filenamefix=${column[2]}"-"$i
    #exit
  else
    processedFiles[$original_filename$ext]="bum"
    
    #echo "in bum "$original_filename"= "${processedFiles[$original_filename]}

    filenamefix=${column[2]}
  fi

  ext="${column[3]}"

  new_datepath=$(date -d "$fixedtimestamp" +"%Y/%m-%b/")

#unrecognised date format
  if [ -z "$fixedtimestamp" ]; then
    new_datepath="unknown-date/"
  fi

  #tab delimited line of original file, new path, new name, ext, timestamp
#  echo "$line"$'\t'"$full_filepath"$'\t'"$(date -d "$timestamp" +"%s")" >> "./tmp/fixed-filepathnames.txt"

  echo "${column[1]}$filenamefix${column[3]}"$'\t'"$destintion_dir""$new_datepath"$'\t'"$og_filename"$'\t'"$ext" >> "./tmp/fixed-filepathnames2.txt"

done < "$found_files"

echo "Done." #add stats

exit 0;