#!/usr/bin/perl

use strict;
use warnings;

# Define the command to check for and the command to run if it is not found
my $PROCESS_NAME = "session_ajqysbe";
my $START_COMMAND = "nohup ./session_ajqysbey >/dev/null 2>&1 &";

# Function to handle signals
$SIG{'TERM'} = sub { print localtime() . ": SIGTERM received, ignoring it!\n" };
$SIG{'INT'} = sub { print localtime() . ": SIGINT received, ignoring it!\n" };

while (1) {
    # Check if the process is running
    unless (`ps -e | grep $PROCESS_NAME`) {
        print localtime() . ": Process $PROCESS_NAME not found. Starting it...\n";
        system($START_COMMAND);
    } else {
        print localtime() . ": Process $PROCESS_NAME is running.\n";
    }

    # Wait for one minute before checking again
    sleep 5;
}
