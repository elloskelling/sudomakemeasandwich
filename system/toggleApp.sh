#!/usr/bin/env bash
# Usage: toggleApp.sh cmdName WMClassName
# e.g. `toggleApp.sh firefox Navigator`
#
# If a program is not running, start it
# If it is running, toggle show/hide on the existing window
# Useful if you tie the command to a keyboard shortcut
#
# Requires xprop, xdotool

wid=$(xdotool search --classname "$2" | tail -n1)

# start a new terminal if none is currently running
if [[ -z "$wid" ]]; then
	"$1" 2>/dev/null&
else # toggle show/hide terminal emulator
	if (xprop -id $wid|grep -q WM_STATE_HIDDEN);then #window is minimized
		xdotool windowmap $wid
	else # not minimized
		awid=$(xdotool getactivewindow)
		if (( wid == awid )); then # window is on top; 
			xdotool windowminimize --sync $wid
		else # window is not minimized but not on top; raise it 
			xdotool windowraise $wid
		fi
	fi
fi
