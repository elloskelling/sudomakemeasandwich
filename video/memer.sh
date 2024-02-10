#!/usr/bin/env bash

: ${1?"Usage: $0 video_with_subs sub_search_string"}

CACHEDIR="$HOME/.memer"
mkdir -p "$CACHEDIR"

IMGOUT=$(basename "${1%.*}-${2}".jpg)

# best cache hack ever
FNAME=$(readlink -f "${1}")
FNAME_CLEAN=$(echo $FNAME|perl -pe "s/[^A-z0-9]/_/g")
SRT="$CACHEDIR/${FNAME_CLEAN}".srt

# best tag stripper ever
# we clean up the subtitles (remove newlines and markup) only for the search. Later, we'll burn them with original formatting
if [ -f "$SRT" ] || ffmpeg -i "${1}" -y -loglevel quiet -map 0:s:0 -f srt -|perl -lnpe 's/\{.*?\}//g;s/\<.*?\>//g;'|perl -pge 's/\r\n/\ /g' > "${SRT}"; then
	# srt_avg will only pull the last matching result
	if ts=$(grep -iC4 "${2}" "${SRT}" |perl -pge "s/.*\n\d+\n(.*\d)\n.*\Q\$ENV{'2'}\E.*\d+\n.*/\1/gsi and s/ --> /\n/g"|srt_avg.py) \
	&& ffmpeg -ss "${ts}" -copyts -i "${1}" -frames:v 1 -ss "${ts}" -vf subtitles="${1}" -loglevel quiet -y "${IMGOUT}"; then
		sushi "${IMGOUT}";
	else
		#echo Failed to extract frame
		exit 2
	fi
else
	#echo Failed to extract SRT
	exit 1
fi


