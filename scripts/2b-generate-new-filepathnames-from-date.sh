#!/bin/bash

found_files=$1
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

#check "run_id" has been entered or create one
if [ -z "$run_id" ]; then
  run_id=$(date +"%s%3N")
fi

#TODO: check if list is correct format

tmp_dir="$(dirname $(dirname $(realpath "$0")))/tmp/"


echo "Processing." #add stats


#purge previous temp file
true > "$tmp_dir/2-generate-new-filepathnames-$run_id.log"

#read each line of "found_files" and generate new filename from file timestamp
while read -r line
do
  #get the timestamp of the file
  timestamp=$(stat -c '%y' "$line") #%y = mtime human-readable? probably could change to %Y

  #create new path from timestamp
  new_date_path=$(date -d "$timestamp" +"%Y/%m-%b/")

  #get filename
  [[ "$line" =~ ^(.+\/)([^\/]+)\. ]]
  filename="${BASH_REMATCH[2]}"

  #get ext, this regex is overkill (and wrong), just need anything after last "."
  [[ $line =~ .([Jj][Pp]([Ee]|)[Gg]|png)$ ]]
  ext="${BASH_REMATCH[0]}"

  #tab delimited line of: original filepath, new path, filename, ext
  echo "$line"$'\t'"$destintion_dir""$new_date_path"$'\t'"$filename"$'\t'"$ext" >> "$tmp_dir/2-generate-new-filepathnames-$run_id.log"

  #TODO check file was written to?

  #log to screen
  #echo ""$line" will become: "$full_filepath""
done < "$found_files"

echo "Done." #add stats

exit 0;