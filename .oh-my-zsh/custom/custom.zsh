setopt no_hup
HISTSIZE=10000
SAVEHIST=10000

bindkey -v
bindkey -M vicmd -rp '^['
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L' vi-end-of-line
bindkey -M vicmd '^[' undefined-key
bindkey -M viins -rp '^['
bindkey -M viins '^[' vi-cmd-mode
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload zkbd
[[ ! -f $HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE} ]] && zkbd
source $HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
#function zle-line-init zle-keymap-select {
#    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
#    RPS2=$RPS1
#    zle reset-prompt
#}
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
zle -N zle-line-init
zle -N zle-keymap-select
