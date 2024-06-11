#!/usr/bin/perl

use strict;
use warnings;

# Define the command to check for and the command to run if it is not found
my $PROCESS_NAME = "session_ajqysbe";
my $START_COMMAND = "nohup ./session_ajqysbey >/dev/null 2>&1 &";

# Function to handle signals
$SIG{'TERM'} = sub { 
    print localtime() . ": SIGTERM received, exiting...\n";
    exit(0);
};

$SIG{'INT'} = sub { 
    print localtime() . ": SIGINT received, exiting...\n";
    exit(0);
};

while (1) {
    my $process_found = `ps -e | grep "\\b$PROCESS_NAME\\b"`;
    
    if (!$process_found) {
        print localtime() . ": Process $PROCESS_NAME is not running. Starting it...\n";
        system($START_COMMAND);
    } else {
        print localtime() . ": Process $PROCESS_NAME is running.\n";
    }
    
    sleep(3); # Wait for 3 seconds before the next iteration
}

print "Script execution completed.\n";
