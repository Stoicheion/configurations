#!/bin/bash

source "$($HOME/bin/xdg_config_home)/shells/profile"

if is_shell_interactive; then
    set -o vi
fi
