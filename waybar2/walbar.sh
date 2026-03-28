#!/bin/bash

wal -i "$1"

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

pkill waybar
waybar &
