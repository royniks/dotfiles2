#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/.wallpapers"

# Start swww-daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Select wallpaper
selected_wall=$(nsxiv -t -b -o "$WALLPAPER_DIR")

if [ -n "$selected_wall" ]; then
    # 1️⃣ Set wallpaper
    swww img "$selected_wall" --transition-type center --transition-step 90

    # 2️⃣ Generate pywal colors
    wal -i "$selected_wall" -q 2>/dev/null

    # 3️⃣ Extract colors for Waybar (GTK compatible)
    BG=$(jq -r '.special.background' ~/.cache/wal/colors.json)
    FG=$(jq -r '.special.foreground' ~/.cache/wal/colors.json)

    C0=$(jq -r '.colors.color0' ~/.cache/wal/colors.json)
    C1=$(jq -r '.colors.color1' ~/.cache/wal/colors.json)
    C4=$(jq -r '.colors.color4' ~/.cache/wal/colors.json)

    cat > ~/.config/waybar/wal-colors.css <<EOF
@define-color background $BG;
@define-color foreground $FG;
@define-color color0 $C0;
@define-color color1 $C1;
@define-color color4 $C4;
EOF

    # 4️⃣ Restart Waybar smoothly
   pkill -SIGUSR2 waybar


    # 5️⃣ Notification
    notify-send "Wallpaper Set" "Wallpaper + Terminal + Waybar updated: $(basename "$selected_wall")"
fi

