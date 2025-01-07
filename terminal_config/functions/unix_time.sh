# ================================================
# Function: unix_time
# ================================================
# Description:
# This function continuously displays the current Unix timestamp 
# (the number of seconds elapsed since January 1, 1970, 00:00:00 UTC).
#
# Features:
# - Outputs the Unix timestamp in real-time.
# - Updates every second to reflect the current time.
# - Can run indefinitely until manually terminated.
#
# Dependencies:
# - `date` command: Used to retrieve the current Unix timestamp.
# - `sleep` command: Ensures the output updates every second.
#
# Usage:
# - unix_time
#   - Starts an infinite loop that outputs the Unix timestamp every second.
#
# Notes:
# - Use `Ctrl+C` to terminate the function when no longer needed.
# - Ensure the system supports the `date` and `sleep` commands (available on most Unix-based systems).
#
# ================================================

unix_time() {
    while true; do
        date +%s
        sleep 1
    done
}
