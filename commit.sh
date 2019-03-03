#!/bin/bash

# because I'm lazy

git add -A

# getting the commit statement
echo -n "Commit statement: "
read STATEMENT
git commit -m "$STATEMENT" # must be in double-quotes because it will be multiple words long

# if there is no repote repo to push to
if [ "$1" == "local" ] ; then
    echo -e "\033[32mCommitting to local repo ...\033[0m"
    exit
fi

# checking to see if a branch is specified
if [ $# -eq 0 ] ; then
	git push origin master
else
	git push origin "$1" # if the user does some weird input injection technique, I guess
fi
