#!/bin/zsh

local profile_file="$HOME/.config/shells/profile"

if [ -f $profile_file ] && [ -r $profile_file ]; then
    source $profile_file
fi
