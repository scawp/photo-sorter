#!/bin/bash

found_files=$1

#TODO: as input arg, maybe also temp 'generated-filepathnames.txt'
destintion_dir="/mnt/c/testphotos/"

#check "found_files" file exists and isn't empty
if [ ! -f "$found_files" ]; then
    echo "Found file list \"$1\" doesnt exists, qutting."
    exit 1;
elif [ ! -s "$found_files" ]; then
    echo "Found file list \"$1\" is empty, qutting."
    exit 1;
fi

#TODO: check if list is correct format

#purge previous temp file
true > "../tmp/generated-filepathnames.txt"

#read each line of "found_files" and generate new filename from file timestamp
while read -r line
do
  timestamp=$(stat -c '%y' "$line")

  #this regex is overkill (and wrong), just need anything after last "."
  [[ $line =~ .([Jj][Pp]([Ee]|)[Gg]|png)$ ]]
  ext="${BASH_REMATCH[0]}"

  #added tab between dir and filename and extention for easier processing
  #TODO: split up to improve readability
  filename=$(date -d "$timestamp" +"%Y/%b/"$'\t'"%Y-%m-%d-%H%M")

  full_filepath=$destintion_dir$filename$'\t'$ext

  #tab delimited line of original file, new path, new name, ext, timestamp
  echo "$line"$'\t'"$full_filepath"$'\t'"$(date -d "$timestamp" +"%s")" >> "../tmp/generated-filepathnames.txt"

  #TODO check file was written to?

  #log to screen
  echo ""$line" will become: "$full_filepath""
done < "$found_files"

#sort generated file in order for further processing
sort -t $'\t' -k5 -o"../tmp/generated-filepathnames.txt" "../tmp/generated-filepathnames.txt"

exit 0;