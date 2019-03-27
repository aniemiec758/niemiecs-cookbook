#!/bin/bash

# "swompt" stands for "swap prompt", letting you change the PS1 local variable originally set in your .bashrc
# this is totally me leveraging a github.com repo just so I can synchronize all my shell scripts across devices, but you might like these too

# must have a function that does all the work because this script must be sourced (so PS1 actually changes in parent shell); this means we can't use `exit` without killing the shell
script_body() {
    if [ $1 = "--help" ] ; then
        echo "To reset your prompt from before you ran this script, run: swompt --default"
        echo " Current prompts: bigboy, clean, gradient"
        return
    fi

    if [[ $1 = "--default" || $1 = "default" || $1 = "d" || $1 = "--d" || $1 = "-default" || $1 = "-d" ]] ; then # I get lazy and forgetful, so catch every case
        if [ "$PS1" = "$OLDPS1" ] ; then # must use double quotes because we have no idea if the user has a completely blank default prompt
            echo " Quit foolin' around"
        fi
        PS1=$OLDPS1
        # declutter the user, given that this script is sourced and any flag variables will linger around
        OLDPS1=""
        NIEMIEC_SWOMPTBOOL=""
        return
    fi

# this is where the fun begins (again)

    if [ $1 = "bigboy" ] ; then # this if-statement ALONE is the entire reason I made this script; it was 2AM and I felt inspired
        PS1="\033[0m╔╗   ╔╗               ═╗═╗     \n║║║║║║║ ║║║╔╗╬'╔ ╬║ º╔╔╝╔╝     \n╚╝╚╩╝╚╝ ╚╩╝╚╩╚ ╝ ╚╠╗║╝º º  \! > " # you easily could have called this script "glompt.sh"
        return
    fi

    if [ $1 = "clean" ] ; then
        S=`shorthostname`
        PS1="\033[0m$S \! > "
        return
    fi

    if [ $1 = "gradient" ] ; then
        PS1="`echo -ne "\033[2m\033[46;34m░░░▒▒▓▓█"; echo -e "\033[44;37m$USER \033[0m \! > "`"
        return
    fi

    # if the function hasn't returned by now, that means that this ain't it, chief
    echo "Error: prompt does not exist"
    echo " For a list of prompts, see: swompt --help"
}

if [ $# -lt 1 ] ; then
    echo "Usage: swompt <prompt_name>"
    echo " For a list of prompts, see: swompt --help"
else
    if [ "$NIEMIEC_SWOMPTBOOL" = "" ] ; then # user HAS NOT run this script, meaning PS1 is currently the default (or however the user messed with it before running this script, not my problem); $SWOMPTBOOL must be in quotes, because when it is expected to be empty, serious syntax errors would be thrown
        OLDPS1=$PS1
    fi
    NIEMIEC_SWOMPTBOOL="TRUE" # lets us know when NOT to overwrite OLDPS1 var; sadly, because this script (by definition) must be sourced, this clutter stays with the user...
    script_body "$1" # even if the script prints an error or doesn't actually change the prompt, we already have the original PS1 and don't have to worry about unsetting $SWOMPTBOOL (it would honestly be inefficient to unset it just to reset it next time the script is run)
fi

# the true alternative is to `grep ~/.bashrc | awk ...` the PS1 somehow, but there are a few difficulties in doing so:
#   the PS1 may be multi-line, and I don't know awk that well
#   the .bashrc might be somewhere completely different if the user decided to move it from their home directory, or their distro does this by default for some reason
#   the user might not even be using bash (i.e. zsh or csh) and looking for a .bashrc may be fruitless/pointless
