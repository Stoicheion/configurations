#!/bin/sh

xrdb -load $HOME/.Xresources &
xmodmap $HOME/.config/Xmodmap &
urxvtd &
start-pulseaudio-x11 &

exec $HOME/.xinitrc awesome
