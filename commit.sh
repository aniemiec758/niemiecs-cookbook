#!/bin/bash

# because I'm lazy

# getting the commit statement FIRST (user might ctrl-c if they change their mind)
echo -n "Commit statement: "
read STATEMENT
git add -A
git commit -m "$STATEMENT" # must be in double-quotes because it will be multiple words long

# if the user doesn't want to push to remote
if [ "$1" == "local" ] ; then
    echo -e "\033[32mCommitting to local repo ...\033[0m"
    exit
fi

# checking to see if a branch is specified, given that the user wants to push to remote
if [ $# -eq 0 ] ; then
	git push origin master
else
	git push origin "$1" # double-quoted in case the user somehow has a branch name that uses spaces, and they pass in two words as one argument??
fi
