#!/usr/bin/env bash

function count_windows() {
	DESKTOP_ID=$(xprop -notype -root _NET_CURRENT_DESKTOP |
		cut -c 24-)

	xdotool search --all --onlyvisible --desktop "$DESKTOP_ID" "" 2>/dev/null |
		wc -l
}

function count_adbdevices() {
	adb devices |
		grep -c 'device$'
}

# This script only works in a empty workspace to create new windows.

if [ "$(count_windows)" -ne 0 ]
then
	notify-send "$0" "You need to be in a empty workspace."

	exit 1
fi

# Open the applications that I would like in that scratchpad workspace.

win_count=0

firefox --browser &
sleep 1
firefox "https://open.spotify.com"

(( win_count += 1 ))

if [ "$(count_adbdevices)" -ne 0 ]
then
	scrcpy --prefer-text &

	(( win_count += 1 ))
fi

st -e tmux new -s "scratchpad" &

(( win_count += 1 ))

# Change the layout of the windows and move to the scratchpad.

while [ "$(count_windows)" -ne "$win_count" ]
do
	echo "Wating for the windows being created."
done

i3 layout tabbed
i3 focus parent
i3 move scratchpad
i3 scratchpad show

for _ in $(seq "$win_count")
do
	i3 focus left
done
