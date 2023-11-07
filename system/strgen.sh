#!/usr/bin/env zsh

NUMWORDS=$1

dict="/usr/share/dict/words"

strs=""
for ki in $(seq 1 $NUMWORDS); do
	str=$(sed -n "$(shuf -n 1 -i 1-$(wc -l "$dict"|perl -lne 's/^\D*(\d+)\s.*/$1/g and print')) p" "$dict")
	strs+="${(C)str}"
	strs+=$(perl -e '@c = qw(0 1 2 3 4 5 6 7 8 9 # $ % & * ? ! @ + - _ [ ] { } \( \)) and print $c[int(rand(scalar(@c)+1))]')
done
echo ${strs%?}
