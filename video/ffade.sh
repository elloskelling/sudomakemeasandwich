#!/usr/bin/env zsh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 input.mp4 fade_duration output.mp4"
    exit 1
fi

fad="${2}";
dur=$(ffprobe -v quiet -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1 "${1}"|sed 's/duration=//');
bit=$(ffprobe -v quiet -select_streams v:0 -show_entries format=bit_rate -of default=noprint_wrappers=1 "${1}"|sed 's/bit_rate=//');
a=0;
b=$(($dur - $fad));
echo "ffmpeg -i \"${1}\" -vf \"fade=t=in:st=$a:d=$fad,fade=t=out:st=$b:d=$fad\" -af \"afade=t=in:st=0:d=$fad,afade=t=out:st=$b:d=$fad\" -b:v $bit \"${3}\""
echo Press any key to execute or Ctrl-C to abort
read
ffmpeg -i "${1}" -vf "fade=t=in:st=$a:d=$fad,fade=t=out:st=$b:d=$fad" -af "afade=t=in:st=0:d=$fad,afade=t=out:st=$b:d=$fad" -pix_fmt yuv420p -b:v $bit "${3}"

# for iphone -pix_fmt yuv420p
