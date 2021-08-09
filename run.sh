#!/bin/bash

#echo -n "Source folder: "
#read source

#echo "$source"

main_dir="$(dirname $(realpath "$0"))"
scripts_dir="$(dirname $(realpath "$0"))/scripts"
tmp_dir="$(dirname $(realpath "$0"))/tmp"

run_id=$(date +"%s%3N")

#should add these to arg list for run.sh
source_dir="/mnt/c/Users/rob/Pictures/crap from z3/WhatsApp Images"
destintion_dir="/mnt/p/photos/"

#run the scripts

"$scripts_dir/1-find-and-log-matches.sh" "$source_dir" "$run_id"
"$scripts_dir/2a-generate-new-filepathnames-from-name.sh" "$tmp_dir/1-find-and-log-matches-$run_id.log" "$destintion_dir" "$run_id"
#"$scripts_dir/3-create-new-files-and-paths.sh" "$tmp_dir/tmp/2-generate-new-filepathnames-$run_id.log"