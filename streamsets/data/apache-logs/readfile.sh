#!/bin/bash

# Read the file specified on the command line, line by line and
# write it to stdout, sleeping for between 0s and 1s between each
# line

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line"
    sleep 0.$(( ( RANDOM % 30 )  + 1 ))
done < "$1"
