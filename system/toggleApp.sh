#!/bin/sh
# Usage: toggleApp.sh [cmdName] [wmctrlName (from `wmctrl -lx`)]
# e.g. `toggleApp.sh firefox Navigator.firefox`
#
# If a program is not running, start it
# If it is running, toggle show/hide on the existing window
# Useful if you tie the command to a keyboard shortcut
#
# Requires wmctrl, xdotool

t=/tmp/${1}_Minimized7983273829;
b=`wmctrl -lx|grep "${2}"|awk '{print $1}'`;
if [ -z "$b" ];then
	${1} &
	sleep 4;
	mkdir $t;
	sleep 1;
	b=`wmctrl -lx|grep "${2}"|awk '{print $1}'`;
fi
if [ -d $t ];then 
	xdotool windowactivate $b;
	wmctrl -i -R $b -b remove,sticky;
	rmdir $t;
else
	xdotool windowminimize $b;
	wmctrl -i -R $b -b add,sticky;
	mkdir $t;
fi
