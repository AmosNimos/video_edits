#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &>/dev/null; then
    echo "Error: ffmpeg is not installed. Install it and try again."
    exit 1
fi

TMP_FILELIST="filelist.txt"
OUTFILE="mix.mp3"

# Remove any old temporary file
rm -f "$TMP_FILELIST"

# Create a file list for ffmpeg
for mp3 in *.mp3; do
    echo "file '$mp3'" >>"$TMP_FILELIST"
done

# Check if the file list is empty
if [[ ! -s $TMP_FILELIST ]]; then
    echo "No MP3 files found in the current directory."
    rm -f "$TMP_FILELIST"
    exit 1
fi

# Merge the MP3 files with re-encoding to avoid duration issues
echo "Merging MP3 files into $OUTFILE..."
ffmpeg -f concat -safe 0 -i "$TMP_FILELIST" -acodec libmp3lame -qscale:a 2 "$OUTFILE" -y

# Cleanup
rm -f "$TMP_FILELIST"

echo "Merge complete: $OUTFILE"
