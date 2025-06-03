#!/bin/bash

# Step 1: Install yt-dlp if not installed
if ! command -v yt-dlp &> /dev/null
then
    echo "yt-dlp not found. Installing..."
    sudo apt update
    sudo apt install -y python3-pip
    pip install -U yt-dlp --break-system-packages
fi

# Step 2: Install ffmpeg if not installed (for merging audio+video)
if ! command -v ffmpeg &> /dev/null
then
    echo "ffmpeg not found. Installing..."
    sudo apt install -y ffmpeg
fi

# Step 3: Ask for YouTube link
read -p "Enter YouTube video URL: " YT_URL

# Step 4: Set download path to Downloads folder
DOWNLOAD_DIR="$HOME/Downloads"

# Step 5: Download in 1080p and save as MP4 to Downloads folder
echo "Downloading to $DOWNLOAD_DIR ..."
yt-dlp -f "bestvideo[height=1080]+bestaudio/best[height=1080]" --merge-output-format mp4 -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" "$YT_URL"

echo "✅ MP4 video saved in your Downloads folder."
