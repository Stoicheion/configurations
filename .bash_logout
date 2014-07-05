#!/bin/bash

function main {

local logout_file="$HOME/.config/shells/logout"

if [ -f $logout_file ] && [ -r $logout_file ]; then
    source $logout_file
fi
}

main
unset -f main
