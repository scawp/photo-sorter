#!/bin/bash

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
while read -r line
do
  #todo think of better name
  #0 original path, 1 destination dir, 2 new filename, 4 timestamp
  IFS=$'\t'; arrayThing=($line); unset IFS;

  mkdir -p "${arrayThing[1]}"

  #move could be a better option? espesially if source and destination are on the same drive
  cp --backup=numbered "${arrayThing[0]}" "${arrayThing[1]}${arrayThing[2]}" 
  echo "creating ${arrayThing[1]}${arrayThing[2]}"
done < "$generated_list"

exit 0;