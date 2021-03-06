#!/bin/bash

# see crude justification at bottom to see why we need a function
script_body() {
	# general usage
	if [ $# -ne 1 ] ; then
		echo "Usage: syntax <file descriptor, i.e. cpp or py>"
		return
	fi

	# opening proper syntax file
	DESCRIPTOR="/usr/share/nano/$1.nanorc"
	if ! [[ -f "$DESCRIPTOR" ]] ; then # file doesn't exist
		echo -n "Error: could not find $1.nanorc. Would you like to create it? <y/n> "

		read RESP # get input from user
		if [[ $RESP != 'y' && $RESP != 'Y' ]] ; then # user doesn't want to create the file
			return
		fi
	fi

	# either the file exists, or the user wants to create it anyways
	sudo nano $DESCRIPTOR
}

# some clever messing around: because this script involves the `cd`
#	command, we cannot simply call the script normally - the shell
#	script would be run in a subshell, and the user wouldn't actually
#	be moved when the script exits
# instead, because we must `source` the script so that the parent
#	terminal switches directory, we cannot invoke `exit` or else the
#	user's terminal would shut down (like running `exit` normally)
# one solution is to use the `return` keyword, and turn the script
#	body into a function (because calling `return` outside of a
#	function will echo an error and keep running the script line-
#	by-line, causing mass destruction and rampant chaos ...)

# if the user just wants to go to the directory
if [ $# -eq 0 ] ; then
	cd "/usr/share/nano" # navigate to the syntax config folder
	clear; clear; pwd; ls # execute a `cls`: Niemiec's favorite flavor of clearing the terminal
else # otherwise, go through with the rest of the script
	script_body $1 # don't have to use "$1" because we know that there is at least one argument by now ($1 exists) ...
fi
