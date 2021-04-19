#!/bin/bash

ffmpeg -video_size "1920x1080" -f x11grab  -i "$DISPLAY" -frames:v 1 -f image2pipe -vcodec png -compression_level 100 /tmp/file.png

clip=0

if [[ "$1" == "clipboard" ]]; then
	clip=1
else
	echo "we are in else statemtn"
	isclip=$(printf "To Clipboard\nTo File" | rofi -dmenu)
	if [[ "$isclip" == "To Clipboard" ]]; then
		clip=1
	fi
fi

if [[ "$clip" == 1 ]]; then
	xclip -selection clipboard -t "image/png" -i /tmp/file.png
	rm /tmp/file.png
else
	filepath=$(rofi -dmenu)
	mv /tmp/file.png "$HOME/$filepath"
fi
