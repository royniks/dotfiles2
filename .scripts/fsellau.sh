#!/usr/bin/env bash

kitty --title fsel-float -e fsel &
sleep 0.2
swaymsg [title="fsel-float"] floating enable, resize set 900 600, move position center

