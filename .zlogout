#!/bin/zsh

local logout_file="$HOME/.config/shells/logout"

if [ -f $logout_file ] && [ -r $logout_file ]; then
    source $logout_file
fi
