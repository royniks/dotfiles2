#!/bin/sh

wallpaper=$(ls /home/zeke/.wallpapers | dmenu -i -l 50)

[ $wallpaper -z ] || feh --bg-fill /home/zeke/.wallpapers/$wallpaper
[ $wallpaper -z ] || wal -i /home/zeke/.wallpapers/$wallpaper
