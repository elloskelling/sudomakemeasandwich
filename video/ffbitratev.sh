#!/usr/bin/env sh
ffprobe -v quiet -select_streams v:0 -show_entries format=bit_rate -of default=noprint_wrappers=1 "$1"|sed 's/bit_rate=/-b:v /'
