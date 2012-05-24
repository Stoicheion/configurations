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
export EDITOR=vim
