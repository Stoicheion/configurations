#!/bin/zsh

local environment_variables_file="$HOME/.config/shells/environment_variables"

if [ -f $environment_variables_file ] && [ -r $environment_variables_file ]; then
    source $environment_variables_file
fi
