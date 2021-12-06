#!/bin/bash

#echo -n "Source folder: "
#read source

#echo "$source"

main_dir="$(dirname $(realpath "$0"))"
scripts_dir="$(dirname $(realpath "$0"))/scripts"
tmp_dir="$(dirname $(realpath "$0"))/tmp"

run_id=$(date +"%s%3N")

#should add these to arg list when run direct
#when running docker these should be configured in the volumes
source_dir="/mnt/source/"
destintion_dir="/mnt/destination/"
#run the scripts
"$scripts_dir/1-find-and-log-matches.sh" "$source_dir" "$run_id"
"$scripts_dir/2a-generate-new-filepathnames-from-name.sh" "$tmp_dir/1-find-and-log-matches-$run_id.log" "$destintion_dir" "$run_id"

echo -n "Do you want to process the files contained in "$tmp_dir/1-find-and-log-matches-$run_id.log" ? (y/n) "
read confirm
if [ "$confirm" = "y" ]; then
  echo "running"
  "$scripts_dir/3-create-new-files-and-paths.sh" "$tmp_dir/2-generate-new-filepathnames-$run_id.log"
else
  echo -e "Quitting, to continue, run:\n"$scripts_dir/3-create-new-files-and-paths.sh" "$tmp_dir/2-generate-new-filepathnames-$run_id.log""
fi