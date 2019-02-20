#!/bin/bash

# if the user just wants to go to the directory
if [ $# -eq 0 ] ; then
	cd "/usr/share/nano" # navigate to the syntax config folder
	clear; clear; pwd; ls # execute a `cls`
	exit
fi

# general usage
if [ $# -ne 1 ] ; then
	echo "Usage: syntax <file descriptor, i.e. cpp or py>"
	exit
fi

# opening proper syntax file
DESCRIPTOR="/usr/share/nano/$1.nanorc"
if ! [[ -f "$DESCRIPTOR" ]] ; then # file doesn't exist
	echo -n "Error: could not find $1.nanorc. Would you like to create it? <y/n> "

	read RESP
	if [[ $RESP != 'y' && $RESP != 'Y' ]] ; then # user doesn't want to create the file
		exit
	fi
fi

# either the file exists, or the user wants to create it anyways
sudo nano $DESCRIPTOR
