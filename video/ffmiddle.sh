#!/usr/bin/env zsh

input="${1}"
output="${2}"
ffmpeg -ss $(bc -l <<< $(ffprobe -loglevel error -of csv=p=0 -show_entries format=duration "$input")*0.3) -i "$input" -frames:v 1 -y "$output"