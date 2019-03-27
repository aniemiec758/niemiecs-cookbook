#!/bin/bash

# THIS STARTED AS A PROOF OF CONCEPT BUT IT'S STILL PRETTY FUN

# arguments checking
MSG="mmeep"
if [ $# -gt 0 ] ; then
	MSG=$1
fi

# infinite color loop
LOOPER=1
while [ $LOOPER -le 5 ] ; do
	# saving our current cursor position, to return to later
	source ./getCursor.sh
	OLDPOS=$CPOS

	# moving the cursor to a completely random position
	X=$(( RANDOM % 100 ))
	Y=$(( RANDOM % 50 ))
	echo -ne "\033["$Y";"$X"H"

	# pick a random color and going with it
	COLOR=$(( 30+$((RANDOM % 8)) ))
	echo -ne "\033["$COLOR"$MSG"

	# restoring our original cursor position
	echo -ne "\033["$OLDPOS"H"

#	(( LOOPER++ ))
	sleep 0.05 # so the blink isn't too fast to perceive
done
