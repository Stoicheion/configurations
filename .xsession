#!/bin/sh

export GTK_IM_MODULE="uim"
export QT_IM_MODULE="uim"
export XMODIFIERS="@im=uim"

xrdb -load $HOME/.Xresources &
xmodmap $HOME/.config/Xmodmap &
uim-xim &
urxvtd &
start-pulseaudio-x11 &

exec $HOME/.xinitrc awesome
