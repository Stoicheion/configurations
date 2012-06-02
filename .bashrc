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

if [ -f $HOME/.config/private/bashrc ]
then
	source $HOME/.config/private/bashrc
fi

set -o vi

export TERMINAL_FILE_MANAGER=vifm
export TERMINAL_WEB_BROWSER=links
export TERMINAL_EMAIL_READER=mutt
export TERMINAL_FEED_READER=newsbeuter
export TERMINAL_AUDIO_PLAYER=mocp
export TERMINAL_VIDEO_PLAYER=mplayer
export TERMINAL_IRC_CLIENT=weechat-curses
export TERMINAL_CHAT_CLIENT=weechat-curses
export TERMINAL_TORRENT_DOWNLOADER=rtorrent
export TERMINAL_SPREADSHEET=sc
export GRAPHICAL_TERMINAL_EMULATOR=urxvtc
export GRAPHICAL_FILE_MANAGER="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_FILE_MANAGER"
export GRAPHICAL_WEB_BROWSWER=firefox
export GRAPHICAL_EMAIL_READER="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_EMAIL_READER"
export GRAPHICAL_FEED_READER="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_FEED_READER"
export GRAPHICAL_AUDIO_PLAYER="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_AUDIO_PLAYER"
export GRAPHICAL_VIDEO_PLAYER=mplayer
export GRAPHICAL_IRC_CLIENT="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_IRC_CLIENT"
export GRAPHICAL_CHAT_CLIENT="$GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_CHAT_CLIENT"
export GRAPHICAL_TORRENT_DOWNLOADER="GRAPHICAL_TERMINAL_EMULATOR -e $TERMINAL_TORRENT_DOWNLOADER"
export GRAPHICAL_SPREADSHEET=gnumeric

if [[ -n $DISPLAY ]]; then
	export FILE_MANAGER=$GRAPHICAL_FILE_MANAGER
	export WEB_BROWSER=$GRAPHICAL_WEB_BROWSWER
	export EMAIL_READER=$GRAPHICAL_EMAIL_READER
	export FEED_READER=$GRAPHICAL_FEED_READER
	export AUDIO_PLAYER=$GRAPHICAL_AUDIO_PLAYER
	export VIDEO_PLAYER=$GRAPHICAL_VIDEO_PLAYER
	export IRC_CLIENT=$GRAPHICAL_IRC_CLIENT
	export CHAT_CLIENT=$GRAPHICAL_CHAT_CLIENT
	export TORRENT_DOWNLOADER=$GRAPHICAL_TORRENT_DOWNLOADER
	export SPREADSHEET=$GRAPHICAL_SPREADSHEET
	export EDITOR=vim
	#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | view -c 'set ft=man nomod nolist' -\""
	export PAGER=less
else
	export FILE_MANAGER=$TERMINAL_FILE_MANAGER
	export WEB_BROWSER=$TERMINAL_WEB_BROWSER
	export EMAIL_READER=$TERMINAL_EMAIL_READER
	export FEED_READER=$TERMINAL_FEED_READER
	export AUDIO_PLAYER=$TERMINAL_AUDIO_PLAYER
	export VIDEO_PLAYER=$TERMINAL_VIDEO_PLAYER
	export IRC_CLIENT=$TERMINAL_IRC_CLIENT
	export CHAT_CLIENT=$TERMINAL_CHAT_CLIENT
	export TORRENT_DOWNLOADER=$TERMINAL_TORRENT_DOWNLOADER
	export SPREADSHEET=$TERMINAL_SPREADSHEET
	export EDITOR=vim
	export PAGER=less
fi
