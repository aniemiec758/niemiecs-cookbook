#!/bin/bash

# this script does nothing on its own (which is why it isn't in the additives.txt)
#	if you `source` this script from some parent script, the parent script will have $CPOS ...

echo -e "\033[6n"		# ANSI escape sequence for current cursor pos, but needs some trimming
read -s -d\[ garbage_val	# removes unwanted prefix of the string
read -s -d R CPOS		# removes unwanted 'R' character from the end
