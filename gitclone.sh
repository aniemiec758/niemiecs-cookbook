#!/bin/bash

# 'help' printout
if [ "$1" = "help" ] ; then
	echo -e "\t\t-Anthony Niemiec Spring 2019-"
	echo -e "\tDoes all the work of cloning a github repo to your local computer and configures it to push updates to your personal github repo\n"
	echo -e "\tExample: gitclone.sh https://github.com/arcosin/CS390-NIP_Lab0_skeleton.git https://github.com/aniemiec758/CS390-NIP_Lab0.git CS390-NIP_Lab0 0-lab"
	echo -e "\t\tWhere I'm \`aniemiec758\`, and I'm cloning \`arcosin\`'s work"
	echo -e "\t\tEverything will be placed into a folder name of your choosing (i.e. \`0-lab\`)"
	echo ""
	exit
fi

# argument checking
if [ $# -ne 4 ] ; then
	echo "Usage: $0"
	echo -e "\t<their github repo URL>"
	echo -e "\t<your github repo URL>"
	echo -e "\t<their local repo folder>"
	echo -e "\t<your local repo folder>"
	echo -e "\nFor an example, type \`gitclone.sh help\`"
	exit
fi

# this is where the fun begins ...


