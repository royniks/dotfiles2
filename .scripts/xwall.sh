#!/usr/bin/env bash

# 1. Choose the image
WALLPAPER_DIR="$HOME/.wallpapers"
selected_wall=$(nsxiv -t -b -o "$WALLPAPER_DIR")

if [ -n "$selected_wall" ]; then
    # 2. Set the wallpaper (X11 style)
    feh --bg-fill "$selected_wall"

    # 3. Generate colors with pywal
    # -n skips setting wallpaper (feh did it), -q is quiet mode
    wal -i "$selected_wall" -n -q 2>/dev/null

    # 4. Update the X server (This makes NEW 'st' terminals use the colors)
    xrdb -merge "$HOME/.cache/wal/colors.Xresources"

    # 5. Tell AwesomeWM to update the bar
    echo "awesome.emit_signal('colors::update')" | awesome-client

    notify-send "Theme Updated" "New colors applied."
fi
