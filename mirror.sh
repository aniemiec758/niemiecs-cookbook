#!/bin/bash

# arguments checking/usage statement
if [ $# -lt 1 ] ; then
    echo "Usage: \`mirror <filename>\`"
    exit
fi

# already have a mirror file open, or the user for some reason had a file named "tmp_mirror_file"
if [ -e tmp_mirror_file ] ; then
    echo "Error: tmp_mirror_file already exists!"
    echo -ne "  Open another one anyways? (overwrites old tmp_mirror_file) [y/n] "
    read RESP
    if [[ $RESP != 'y' && $RESP != 'Y' && "$RESP" != "yes" && "$RESP" != "Yes" ]] ; then # if anything other than a "yes" was given
        exit
    fi
fi

# if the file specified doesn't exist
if [ ! -e "$1" ] ; then
    echo "Error: $1 could not be found"
    exit
fi

# it's a simple script, but quite unbreakable
cat $1 > tmp_mirror_file_$1
nano tmp_mirror_file_$1
rm tmp_mirror_file_$1
