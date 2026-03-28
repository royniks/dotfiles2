#!/usr/bin/env bash

# Path to your wallpaper directory - Ensure this path is correct!
WALL_DIR="$HOME/Pictures/gruvbox"

# Check if swww-daemon is running
pgrep -x "swww-daemon" > /dev/null || swww-daemon &

# Get list of images and format for rofi with icons
# We use -show-icons and a custom theme-str to force large previews
selected=$(ls "$WALL_DIR" | while read -r file; do
    echo -en "$file\0icon\x1f$WALL_DIR/$file\n"
done | rofi -dmenu -i -p "Wallpapers" \
    -show-icons \
    -theme-str 'configuration { show-icons: true; } 
                listview { columns: 3; lines: 3; } 
                element { orientation: vertical; padding: 10px; } 
                element-icon { size: 150px; }' )

# Apply selection
if [ -n "$selected" ]; then
  echo "$WALL_DIR/$selected" > "$HOME/.cache/.last_wallpaper"
    swww img "$WALL_DIR/$selected" --transition-type center --transition-fps 60
fi
