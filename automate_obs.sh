#!/bin/bash

# Step 1: Update packages
echo "Updating system..."
sudo apt update

# Step 2: Install OBS Studio
echo "Installing OBS Studio..."
sudo apt install -y obs-studio

# Step 3: Install obs-websocket (latest 5.0 version for Ubuntu)
echo "Installing obs-websocket plugin..."
sudo apt install -y wget unzip
wget https://github.com/obsproject/obs-websocket/releases/latest/download/obs-websocket-5.3.1-Ubuntu64.deb
sudo dpkg -i obs-websocket-5.3.1-Ubuntu64.deb

# Step 4: Start OBS Studio in background
echo "Starting OBS Studio..."
obs &

# Wait for OBS to load
sleep 10

# Step 5: Import Scene/Profile (Assume you provide `profile.json`)
# You should export profile manually once and reuse the config folder

# Step 6: Connect to OBS via websocket & load media file
# This example assumes the obs-websocket password is disabled or set to "secret"

# Load a video source and start streaming via WebSocket (using curl or websocat)
echo "Sending commands to OBS..."

# Replace these:
VIDEO_PATH="/home/yourusername/Videos/yourvideo.mp4"
STREAM_KEY="your_stream_key"
RTMP_URL="rtmp://your-stream-server/live"

# JSON for setting stream settings and starting stream
curl -X POST http://localhost:4455 -H "Content-Type: application/json" \
    -d '{
  "op": 6,
  "d": {
    "requestType": "SetInputSettings",
    "requestId": "1",
    "requestData": {
      "inputName": "Media Source",
      "inputSettings": {
        "local_file": "'"$VIDEO_PATH"'"
      }
    }
  }
}'

# Start streaming
curl -X POST http://localhost:4455 -H "Content-Type: application/json" \
    -d '{
  "op": 6,
  "d": {
    "requestType": "StartStream",
    "requestId": "2"
  }
}'
