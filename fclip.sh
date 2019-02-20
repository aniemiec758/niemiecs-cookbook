#!/bin/bash

usage() {
	echo "Usage: fclip <file> [-c | -cpp | -py] [-nocopy | -old]"
}

echo "Work in progress. To do:"
echo "	* Clip all whitespace at the end of lines"
echo "	* Create flags for .c, .cpp, .py, etc common extensions"
echo "	* Place all method headers on the same line"

# usage
if [ $# -lt 1 ] ; then # no file specified
	usage
	exit
fi

# etc usage
if ! [[ -f $1 ]] ; then # first argument isn't a file
	echo "Error: could not find file \"$1\""
	echo -n "  "; usage
	exit
fi

# flag parsing

# potential flags:
#	-c, -cpp, -py: for filetype
#	-nocopy: instead of making file_fclip.ext, file.ext will be the fclipped version
#	-old: file_old.ext will hold the original file.ext, and the new file.ext will be fclipped
#		without -copy or -uncopy, file.ext will be the unchanged original and file_fclip.ext will be created
#	-white: only clips whitespace and does literally nothing else
