#!/bin/bash

# Folder to organise (default: current directory)
FOLDER="${1:-.}"

# Loop through files only (skip directories)
find "$FOLDER" -maxdepth 1 -type f | while read -r file; do
    # Get last modified date in YYYY-MM format
    folder_name=$(date -r "$file" +"%Y-%m")

    # Create the destination folder if it doesn’t exist
    mkdir -p "$FOLDER/$folder_name"

    # Move the file
    mv "$file" "$FOLDER/$folder_name/"
done

echo "Organisation complete!"
