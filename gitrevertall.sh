#!/bin/bash

# error checking
# seeing if cwd is a git repo
if ! [ -d .git ] ; then
	echo "Error: this is not a git repository!"
	exit
fi

# checking number of arguments
if [ $# -ne 1 ] && [ $# -ne 2 ] ; then
	echo "Usage: gitrevertall <revert key> <subdir>?"
	echo "For help, type \"gitrevertall help\""
	exit
fi

# 'help' printout
if [ "$1" = "help" ] ; then
	echo -e "\t\t-Anthony Niemiec Winter 2018-"
	echo -e "\tSoftly reverts all files in a git repo to a certain commit by running \"git show <revert key>:<filename> > <filename>\" on all files in the current directory"
	echo -e "\tIf a file in the directory is not part of the git log, it won't be modified"
	echo -e "\tTo get the <revert key>, run \"git log\" and look for \"commit <some random hash>\""
	echo -e "\tThis will currently NOT run within subdirectories - the optional <subdir>? argument will specify which subdir folder to affect"
	echo -e "\tREMEMBER: commit all code before running this command - uncommited changes will be lost!"
	echo ""
	exit
fi

# seeing if the <revert key> is valid
$(git show $1 &>/dev/null) # stdout and stderr are piped to the bit bucket because this is just a test
if [ $? -ne 0 ] ; then # code 128 or something was thrown
	echo "Error: revert key <$1> does not appear to exist"
	exit
fi

# capturing the subdir, if necessary
SUBDIR=""
if [ $# -eq 2 ] ; then
	if [ -d "$2" ] ; then
		SUBDIR="$2"
		# if they forgot a / at the end
		if [[ "${SUBDIR:${#SUBDIR}-1}" != "/" ]] ; then
			SUBDIR=$SUBDIR"/"
		fi
	else
		echo "Error: $2 does not appear to exist (are you in the parent directory of the git repo, instead of in the folder you're trying to revert?)"
		echo "\tIf you changed your directory name between the old commit and now, this scipt does not handle that case - rename the subdir to what it originally had been in this case"
		exit
	fi
fi

# cd'ing if necessary
if [[ "$SUBDIR" != "" ]] ; then
	cd $SUBDIR
	if [ $(echo $?) -ne 0 ] ; then
		echo "Error: you must be in the top directory of your git repo before running this, not already be in the subdirectory you wish to revert"
		exit
	fi
fi

# ----------

# the actual script
FILELIST="" # to hold all the files not in the git log
for file in * ; do # for all files in the current directory
# TODO the following command just DOESN'T work for some reason, it keeps mixing in a list of every file in your file hierarchy
#	OLDVERSION=$(git show $1:$file 2>/dev/null) # get the old version; this lets us check if OLDVERSION is empty, i.e. the file wasn't in the git log and would be nuked by the full command
	git show $1:$SUBDIR$file #&>/dev/null # hack because above line doesn't work; goes from O(n+1) to O(2n+1) because this workaround utilizes an exit status and repeats the same command later when writing to file

#	if [ "$OLDVERSION" = "" ] ; then # this file wasn't in the git log
	if [ $? -ne 0 ] ; then
		FILELIST=$FILELIST$SUBDIR$file" " # add to list of files not in git log
	else # file was indeed in the git log
		git show $1:$SUBDIR$file > $SUBDIR$file 2>/dev/null # overwrite the file with the other commit version
	fi
done

# for the files not in the git log...
if [ "$FILELIST" != "" ] ; then # wasn't empty
	echo "List of files not in git log that were not modified:"
	echo -e "\t$FILELIST"
fi




# IN FUTURE:
#	when encountering a directory (-d $file or something), do a recursive call of the git revert
#		currently have a way to run within a given subdirectory when specified
#	fix the note at the start of the for-loop
#	put this on github (along with the other scripts?)
