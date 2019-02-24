#!/bin/bash

# because I'm lazy

git add -A

# getting the commit statement
echo -n "Commit statement: "
read STATEMENT
git commit -m "$STATEMENT" # must be in double-quotes because it will be multiple words long

# checking to see if a branch is specified
if [ $# -eq 0 ] ; then
	git push origin master
else
	git push origin "$1" # if the user does some weird input injection technique, I guess
fi
