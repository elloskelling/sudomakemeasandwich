#!/usr/bin/env bash
# Quake-style drop-terminal for kitty
# See kitty.ds for devilspie settings to force size, hide decorations, etc

wmname="kittydrop"

# find the window ID
wid=$(xdotool search --class "$wmname" | tail -n1)

# start a new terminal if none is currently running
if [[ -z "$wid" ]]; then
	kitty --class "$wmname" --name "$wmname"
else # toggle show/hide terminal emulator
	if (xdotool search --onlyvisible --class "$wmname");then
		# window is visible
		awid=$(xdotool getactivewindow)
		if (( wid == awid )); then # window is visible and on top; unmap it
			xdotool windowunmap --sync $wid
		else # window is visible but not on top; raise it 
			xdotool windowraise $wid
		fi
	else # window is not visible (unmapped); map it (also raises it) 
		xdotool windowmap --sync $wid
	fi
fi
