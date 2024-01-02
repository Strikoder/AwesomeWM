#!/bin/bash

# Define the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Filename for the screenshot
filename="screenshot_$(date +%Y-%m-%d-%H%M%S).png"

# Full path for the screenshot file
filepath="$screenshot_dir/$filename"

# Geometry of the main monitor (replace with your monitor's geometry)
geometry="1920x1080+0+0"

# Use maim to take a screenshot of the main monitor and save it to the specified path
maim -g "$geometry" "$filepath"

# Notify the user
notify-send "Screenshot taken" "Saved as $filename"
