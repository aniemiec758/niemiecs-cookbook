#!/bin/bash

if [ $# -ne 1 ] ; then
	echo "Usage: search <filename>"
	exit
fi

find / -name "$1*" 2>/dev/null
