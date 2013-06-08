# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]]; then
    # Shell is non-interactive. Exit to prevent output from other code.
    return
fi

if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi

if [ -f $HOME/.config/private/bashrc ]; then
    source $HOME/.config/private/bashrc
fi

set -o vi
