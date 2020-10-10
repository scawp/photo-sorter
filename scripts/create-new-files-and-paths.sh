#!/bin/bash

#get args
generated_list=$1

#check "found_files" file exists and isn't empty
if [ ! -f "$generated_list" ]; then
    echo "Generated list \"$1\" doesnt exists, qutting."
    exit 1;
elif [ ! -s "$generated_list" ]; then
    echo "Generated list \"$1\" is empty, qutting."
    exit 1;
fi

#copy original to new path, on duplicate add numbered backup
while read -r line; do
  #0 original path, 1 destination dir, 2 new filename, 4 extention, 5 timestamp
  IFS=$'\t'; column=($line); unset IFS;

  mkdir -p "${column[1]}"

  source_filename="${column[0]}"
  i=0
  conflict_suffix=""
  completed=false

  until $completed; do
    destination_filename="${column[1]}${column[2]}$conflict_suffix${column[3]}"

    echo "Copying $source_filename to $destination_filename"

    if [ -f "$destination_filename" ]; then
      echo "Comparing existing file: $destination_filename"
      if $(cmp -s "$source_filename" "$destination_filename"); then
        #skip file or delete original
        echo "Skipping duplicate file."
        completed=true
      else
        echo "File exists, renaming."
        #add version *-n.jpg
        ((i++))
        conflict_suffix="-$i"
      fi
    else
    #no existing file, do copy or move
    echo "Creating $destination_filename"

    cp --backup=numbered "$source_filename" "$destination_filename" 

    completed=true
    fi
    echo ""
  done
done < "$generated_list"

exit 0;