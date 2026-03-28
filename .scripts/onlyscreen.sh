#!/bin/bash

# 1. Create a timestamp (Format: Year-Month-Day_Hour-Min-Sec)
FILENAME="recording_$(date +'%Y-%m-%d_%H-%M-%S').mkv"
SAVE_DIR="$HOME/Videos/scap"

# Ensure the directory exists
mkdir -p "$SAVE_DIR"

# Trap Ctrl+C
trap 'kill 0' SIGINT
# 3. Record with the Auto-Named file
ffmpeg \
-f x11grab -video_size 1920x1080 -framerate 30 -i :0.0+1920,0 \
-f pulse -i default \
-c:v libx264 -preset ultrafast \
-c:a aac \
"$SAVE_DIR/$FILENAME"

wait

