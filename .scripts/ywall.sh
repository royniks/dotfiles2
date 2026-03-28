#!/usr/bin/env bash

# 1. Choose the image
WALLPAPER_DIR="$HOME/.wallpapers"
# Using nsxiv to pick the wallpaper
selected_wall=$(nsxiv -t -b -o "$WALLPAPER_DIR")

if [ -n "$selected_wall" ]; then
    # 2. Set the wallpaper (X11 style)
    feh --bg-fill "$selected_wall"

    # 3. Generate colors with pywal
    # -n skips setting wallpaper (feh did it), -q is quiet mode
    wal -i "$selected_wall" -n -q 2>/dev/null

    # 4. Update the X server (Crucial for 'st' and patched 'dwm')
    xrdb -merge "$HOME/.cache/wal/colors.Xresources"

    # 5. Tell dwm to refresh (Replaces the awesome-client line)
    # This requires the 'dwm-restartsig' or 'dwm-xrdb' reload logic
    pkill -HUP dwm

    notify-send "Theme Updated" "dwm and st colors refreshed."
fi
