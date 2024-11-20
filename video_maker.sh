#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image.png> <audio.wav>"
    exit 1
fi

# Assign the arguments to variables
IMAGE="$1"
AUDIO="$2"

# Check if the image file exists
if [ ! -f "$IMAGE" ]; then
    echo "Error: Image file '$IMAGE' not found!"
    exit 1
fi

# Check if the audio file exists
if [ ! -f "$AUDIO" ]; then
    echo "Error: Audio file '$AUDIO' not found!"
    exit 1
fi

# Extract the base name without extension for the output video
OUTPUT="${AUDIO%.*}.mp4"

# Create the video using ffmpeg
ffmpeg -loop 1 -i "$IMAGE" -i "$AUDIO" -c:v libx264 -tune stillimage -c:a aac -b:a 192k -pix_fmt yuv420p -shortest "$OUTPUT"

echo "Video created successfully: $OUTPUT"
