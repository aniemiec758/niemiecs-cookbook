#!/bin/bash

# 'help' printout
if [ "$1" = "help" ] ; then
	echo -e "\t\t-Anthony Niemiec Spring 2019-"
	echo -e "\tDoes all the work of cloning a github repo to your local computer and configures it to push updates to your personal github repo\n"
	echo -e "\tExample: gitclone.sh https://github.com/arcosin/CS390-NIP_Lab0_skeleton.git https://github.com/aniemiec758/CS390-NIP_Lab0.git CS390-NIP_Lab0_skeleton 0-lab"
	echo -e "\t\tWhere I'm \`aniemiec758\`, and I'm cloning \`arcosin\`'s work"
	echo -e "\t\tEverything will be placed into a folder name of your choosing (i.e. \`0-lab\`)"
	echo ""
	exit
fi

# argument checking
if [ $# -ne 4 ] ; then
	echo "Usage: gitclone"
	echo -e "\t<their github repo URL>"	# $1
	echo -e "\t<your github repo URL>"	# $2
	echo -e "\t<their local repo folder>"	# $3
	echo -e "\t<your local repo folder>"	# $4
	echo -e "\nFor an example, type \`gitclone.sh help\`"
	exit
fi

# this is where the fun begins ...

# pulling the repo down and shuffling files around
mkdir $4	# create your local folder
git clone $1	# download other person's git repo

# surprise error checking!!
if [ ! -d "$3" ] ; then # if third argument was mistyped
	rm -r $4
	echo ""
	echo "Error: could not find folder $3!"
	echo -e "\tTry again with whatever folder popped up in this directory..."
	exit
fi

cd $3		# go into the freshly downloaded folder
mv * .* ../$4	# move everything here (including .hidden files) into your local folder
cd ..		# move up
rm -r $3	# remove the old folder
cd $4		# go into your folder; because shell scripts are run in SUBSHELL, you won't be in this folder once the script completes (you'd have to `source` the script in order to do that...)

# hooking up folder to your repo instead of the other person's
git remote rename origin upstream
git remote add origin $2

# an added courtesy, from me to you ...
if [ ! -e Makefile ] ; then # if no Makefile existed previously
	echo -e "all: git-commit\n\n.PHONY: git-commit\ngit-commit:\n\tgit add -A\n\tgit commit -m \"commit\"\n\tgit push origin master" > Makefile
	git config credential.helper store # so that you only have to enter your username and password once while pushing
	make
	clear; clear; echo "You may now run \`make\` in ./$4 in order to push to git"
else
	echo -e "all: git-commit <whatever else is specified in \`all:\`>\n\n.PHONY: git-commit\ngit-commit:\n\tgit add -A\n\tgit commit -m \"commit\"\n\tgit push origin master" > makefile-clipping.txt
	clear; clear; echo "Because a Makefile already exists for this repo, instructions of how to add git-commit functionality are in ./$4/makefile-clipping.txt"
	echo -e "\tBefore pushing, run \`git config credential.helper store\` if you want the repo to remember your username and password (so it won't ask for them every single commit)"
fi
