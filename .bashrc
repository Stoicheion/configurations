# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi


# Put your fun stuff here.
export EDITOR=vim
export PAGER="/bin/sh -c \"unset PAGER;col -b -x | view -c 'set ft=man nomod nolist' -\""

if [ -f $HOME/.config/private/bashrc ]
then
	source $HOME/.config/private/bashrc
fi

set -o vi

