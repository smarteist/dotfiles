#!/bin/bash

# Define the list of URLs
urls=(
    "https://download.manjaro.org/gnome/24.2.1/manjaro-gnome-24.2.1-241216-linux612.iso"
)

# Resumable downloader function
download_file() {
    url="$1"
    fileName=$(basename "$url")  # Fixed the missing closing parenthesis

    # Get the file size directly using curl's -I (HEAD request) and grep
    totalSize=$(curl -sI "$url" | grep -i Content-Length | awk '{print $2}' | tr -d '\r')
    [ -z "$totalSize" ] && totalSize="unknown"

    echo "File: $fileName | Total Size: $totalSize bytes"

    if [ -f "$fileName" ]; then
        from=$(stat -c%s "$fileName")
        echo "Resuming from byte $from..."
        curl -L --progress-bar -C $from -o "$fileName" "$url"
    else
        curl -L --progress-bar -o "$fileName" "$url"
    fi

    echo "Finished: $fileName"
}

# Download each file
for url in "${urls[@]}"; do
    download_file "$url"
    echo
done

echo "All downloads complete."

