# ================================================
# Function: display_time
# ================================================
# Description:
# This function continuously displays the current date and time 
# in a 12-hour format, including seconds and AM/PM notation.
#
# Features:
# - Outputs the current date and time in the format: Tue Jan 7 10:02:30 AM.
# - Updates every second to reflect real-time changes.
# - Can run indefinitely until manually terminated.
#
# Dependencies:
# - `date` command: Used to retrieve the current date and time.
# - `sleep` command: Ensures the output updates every second.
# - (Optional) `tput` command: Used for refreshing the display in-place (if implemented).
#
# Usage:
# - display_time
#   - Starts an infinite loop that outputs the current date and time in 12-hour format.
#
# Notes:
# - Use `Ctrl+C` to terminate the function when no longer needed.
# - Ensure the system supports the `date` and `sleep` commands (available on most Unix-based systems).
# - For a stationary output (non-scrolling), consider using `tput` commands to refresh in-place.
#
# ================================================

display_time() {
    while true; do
        printf "\r$(date '+%a %b %d %I:%M:%S %p')   "  # Output time and ensure overwriting
        sleep 1
    done
}
