#!/bin/bash
picom -b &
xrandr --output DP-2 --auto --output DP-4 --auto --right-of DP-2
# nm-applet # doesn't work, breaks the config
