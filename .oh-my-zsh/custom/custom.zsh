autoload -U compinit promptinit
compinit
promptinit; prompt gentoo

if [[ -f $HOME/.config/private/zshrc ]];
then
	source $HOME/.config/private/zshrc
fi

bindkey -v
bindkey -M vicmd -rp '^['
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd '^[' undefined-key
bindkey -M viins -rp '^['
bindkey -M viins '^[' vi-cmd-mode
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload zkbd
[[ ! -f $HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE} ]] && zkbd
source $HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
function zle-line-init zle-keymap-select {
	RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
	RPS2=$RPS1
	zle reset-prompt
}
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select

export PATH=/usr/local/bin:/usr/bin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.5.3:/usr/games/bin:/$HOME/bin

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
