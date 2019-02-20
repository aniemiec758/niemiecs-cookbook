#!/bin/bash

# printing usage
if [ $# -gt 1 ]; then
	echo "Usage: lstat,"
	echo "       lstat <filename>"
	exit
fi

# building up the statement
FORMAT="%n %y %b" # could add -flag options in the future
#STATEMENT="stat --format=\""$FORMAT"\" *"

# if the user is searching for something specific, take that into account
#if [ $# -eq 1 ]; then
#	STATEMENT=$STATEMENT' | grep $1'
#fi

# running stat for every filename, original/modified timestamp, and size; stores it in $RESULT
stat --format="$FORMAT" * | while read FILE; do
#$STATEMENT | while read FILE; do
	# getting arguments
	NAME=$(echo $FILE | awk '{print $1}')
	TIME=$(echo $FILE | awk '{print $2}')
	SEC=$(echo $FILE | awk '{print substr($3,0,8)}') # round to the nearest second
	SIZE=$(echo $FILE | awk '{print $5}')

	# getting AM or PM
	MERID="AM"
	HOUR=$(echo $SEC | cut -c 1-2)
	if [ $HOUR -ge 12 ] ; then
		MERID="PM"
		HOUR=$(($HOUR - 12))
		SEC=$(printf "%02d" $HOUR)$(echo $SEC | cut -c 3-8)
	fi

	# if an argument is supplied, only echo those matches
	if [[ $# -eq 1 && $(echo $NAME | grep $1) ]]; then
		printf "Name: $NAME\n Date Modified: $TIME,\n"
		printf "                $SEC$MERID\n Size (in bytes): $SIZE\n"
	fi

	# echoing anything, regardless
	if [ $# -eq 0 ]; then
		printf "Name: $NAME\n Date Modified: $TIME,\n"
		printf "                $SEC$MERID\n Size (in bytes): $SIZE\n"
	fi
done
