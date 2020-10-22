#!/bin/bash

COUNTER=0

# usage case
if [ $# -ne 1 ] ; then
	echo "Usage: killmy <name of process>"
	exit
fi

# show all processes | find arg1 | don't match for this very process | get the PID column ; loop, killing all matches
for PID in $(ps -u $USER | grep $1 | grep -v 'grep' | awk '{print $1}'); do
	kill -9 $PID
	let COUNTER=COUNTER+1
done

echo "Killed $COUNTER instances of $1"
