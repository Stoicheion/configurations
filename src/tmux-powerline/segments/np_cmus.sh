#!/bin/bash

cmus_pid=$(ps -A | grep -m1 cmus | awk '{print $1}')
if [ -n "$cmus_pid" ]; then
    status=$(cmus-remote -Q | grep "status" | cut -d ' ' -f 2)
    #artist=$(cmus-remote -Q | grep -m 1 "artist" | cut -d ' ' -f 3-)
    title=$(cmus-remote -Q | grep "title" | cut -d ' ' -f 3-)
    track=$(cmus-remote -Q | grep "tracknumber" | cut -d ' ' -f 3)

    np=$(echo "${track} - ${title}")

    if [ "$status" == "playing" ]; then
        echo "♫ ⮀  ${np}"
	else echo "♫ || ${np}"
    fi
fi
