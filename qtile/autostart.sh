#!/bin/bash

# Set wallpaper
feh --bg-fill ~/.config/qtile/assets/wp.png &

# Start picom
picom &

# utilities
xinput set-prop 11 "libinput Tapping Enabled" 1
setxkbmap -option "ctrl:swapcaps"

