# ================================================
# Function: digital_life
# ================================================
# Description:
# This function mounts and opens an encrypted sparsebundle disk image
# located in a specific folder with a path that includes Unicode characters.
#
# Features:
# - Dynamically resolves Unicode characters in the path.
# - Opens the sparsebundle disk image using the `open` command.
# - Provides meaningful error messages for invalid or inaccessible paths.
#
# Dependencies:
# - macOS `open` command: Used to open and mount the disk image.
# - Unicode support in Shell for dynamic path resolution.
#
# Usage:
# - digital_life
#   - Mounts and opens the predefined sparsebundle disk image.
#
# Notes:
# - Ensure the sparsebundle disk image exists at the predefined path.
# - If the path includes non-English characters, ensure your terminal and environment support Unicode.
#
# ================================================

digital_life() {
    # Set awake duration in seconds
    stay_awake_duration=21600
    
    # Calculate the end time for caffeinate
    end_time=$(date -v+${stay_awake_duration}S "+%Y-%m-%d %H:%M:%S")
    
    # Resolve Unicode path dynamically
    sparsebundle_path=$(echo -e "/Volumes/\u54c6\u5566\u0041\u68a6\u306e\u8bb0\u5fc6\u9762\u5305/Computer Software/Mac Intel Applications/Development and Testing/system_backup.sparsebundle")
    
    # Check if the sparsebundle file exists
    if [ ! -e "$sparsebundle_path" ]; then
        echo "Error: Disk image not found."
        return 1
    fi

    # Attempt to open the sparsebundle disk image
    open "$sparsebundle_path"

    # Check if the open command succeeded
    if [ $? -eq 0 ]; then
        echo "\nPassword prompt displayed. Unlock to access.\n"
    else
        echo "Error: Failed to open the disk image."
        return 1
    fi

    # Output the end time, disk mount status, and instructions to terminate the process
    echo -e "System will remain active until: $end_time\nPress CTRL+C or close the terminal to disengage."

    # Run caffeinate to prevent sleep
    caffeinate -m -i -t $stay_awake_duration
}
