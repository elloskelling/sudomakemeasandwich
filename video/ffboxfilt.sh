#!/usr/bin/env zsh

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 [crop|delogo|...] input.mp4 output.mp4"
    exit 1
fi

#tmpframe=$(LC_ALL=C tr -dc A-Za-z0-9 </dev/urandom | head -c 8).jpg

tmpframe=$(mktemp --suffix ".jpg" "/tmp/boxfilt_XXXXXX")

echo "Left-click / right-click to set image box. Press ENTER when done."
ffmiddle.sh "$2" "$tmpframe" &>/dev/null
vfbox=$(imgbox.py "$tmpframe")
rm -f "$tmpframe"

# this keeps the original bitrate which is probably overkill for small crops
bvarg=$(ffbitratev.sh "$2")

cmdl="ffmpeg -i \"$2\" -force_key_frames \"expr:gte(t,n_forced*3)\" -c:a copy -pix_fmt yuv420p -vf \"$1\"=$vfbox $bvarg \"$3\""

echo $cmdl
echo "Any key to proceed. Ctrl-C to abort."
read
eval $cmdl
