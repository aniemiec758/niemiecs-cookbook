#!/bin/bash

# error checking (`git show` will handle all other errors of 'not a git repo', 'hash key not found', and 'file not found'
if [ $# -ne 2 ] ; then
	echo "Usage: rev <revert key> <singular file>"
fi

git show $1:$2 > $2
