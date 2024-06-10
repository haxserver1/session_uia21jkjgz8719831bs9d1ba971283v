#!/bin/bash

# Define the command to check for and the command to run if it is not found
PROCESS_NAME="session_ajqysbe"
START_COMMAND="nohup ./session_ajqysbey >/dev/null 2>&1 &"

# Function to handle signals
trap 'echo "$(date): SIGTERM received, ignoring it!"' SIGTERM
trap 'echo "$(date): SIGINT received, ignoring it!"' SIGINT

while true; do
    # Check if the process is running
    if ! ps -e | grep -q "$PROCESS_NAME"; then
        echo "$(date): Process $PROCESS_NAME not found. Starting it..."
        eval $START_COMMAND
    else
        echo "$(date): Process $PROCESS_NAME is running."
    fi

    # Wait for one minute before checking again
    sleep 3
done
