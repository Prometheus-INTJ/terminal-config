# ================================================
# Function: show_duration
# ================================================
# Description:
# This function calculates the total duration of media files (e.g., `.mp4`) 
# for one or multiple files or directories.
#
# Features:
# - Single file or directory:
#   - Displays the duration of the file or the cumulative duration of all valid media files within the directory.
# - Multiple files or directories:
#   - Shows the duration for each input (file or directory) in a tabular format.
#   - Outputs the cumulative total duration across all inputs.
#
# Additional Functionality:
# - Automatically truncates long filenames for improved readability while maintaining table alignment.
# - Gracefully handles invalid paths or unsupported file formats by skipping them and providing a warning.
# - Provides a detailed summary of total duration across all inputs in a human-readable format.
#
# Dependencies:
# - ffmpeg: Extracts video metadata (e.g., duration).
# - awk: Performs calculations and formats the duration (e.g., into hours, minutes, seconds).
# - column: Ensures tabular alignment in output.
# - basename: Trims paths to display only filenames or directory names.
#
# Usage:
# - Single file: show_duration "/path/to/file.mp4"
# - Single directory: show_duration "/path/to/directory"
# - Multiple files/directories: show_duration "/path/to/file1" "/path/to/dir1" "/path/to/file2"
#
# Example Output:
# - Single file:
#   Name                             Duration
#   file.mp4                         00:12:34
#   Total Duration: 12 minutes, 34 seconds
#
# - Single directory:
#   Name                             Duration
#   dir1/file1.mp4                   01:05:45
#   dir1/file2.mp4                   00:42:10
#   Total Duration: 1 hour, 47 minutes, 55 seconds
#
# - Multiple files/directories:
#   Name                             Duration
#   dir1/file1.mp4                   01:05:45
#   dir2/long_filename_fi...me.mp4   00:42:10
#   invalid_file                     Unsupported format
#   Total Duration: 1 hour, 47 minutes, 55 seconds
#
# Notes:
# - Unsupported or invalid files/directories are logged but excluded from the total duration.
# - Handles long filenames by truncating them and ensuring proper alignment.
#
# ================================================

show_duration() {
    if [ "$#" -eq 0 ]; then
        echo "Please provide at least one file or directory path!"
        return 1
    fi

    total_seconds=0

    # Limit the name length, truncate if it exceeds max_length
    truncate_name() {
        local name="$1"
        local max_length=23
        local name_len=$(echo -n "$name" | wc -c)

        if [ "$name_len" -gt "$max_length" ]; then
            local prefix_length=$(( (max_length - 3) / 2 ))
            local suffix_length=$(( max_length - 3 - prefix_length ))
            local prefix=$(echo -n "$name" | cut -c1-"$prefix_length")
            local suffix=$(echo -n "$name" | rev | cut -c1-"$suffix_length" | rev)
            echo "${prefix}...${suffix}"
        else
            echo "$name"
        fi
    }

    # Create a temporary file to store results
    temp_file=$(mktemp)

    # Add an empty line before the table
    echo
    column -s $'\t' -t < "$temp_file"

    # Add header
    echo -e "Name\t\tDuration" >> "$temp_file"

    for item in "$@"; do
        if [ -f "$item" ]; then
            # Extract duration using ffmpeg, handle errors gracefully
            duration=$(ffmpeg -i "$item" 2>&1 | grep "Duration" | awk '{print $2}' | tr -d , | awk -F: '{ print int(($1 * 3600) + ($2 * 60) + $3) }' 2>/dev/null)
            if [ -z "$duration" ]; then
                # Skip unsupported files
                echo -e "\t$(truncate_name "$(basename "$item")")\tUnsupported format" >> "$temp_file"
                continue
            fi
        elif [ -d "$item" ]; then
            # Process directories, recursively calculate total duration of media files
            duration=$(find "$item" -type f -exec ffmpeg -i {} 2>&1 \; | grep "Duration" | awk '{print $2}' | tr -d , | awk -F: '{ total += ($1 * 3600) + ($2 * 60) + $3 } END { print int(total) }')
        else
            # Handle invalid paths
            echo -e "\t$(truncate_name "$(basename "$item")")\tInvalid path" >> "$temp_file"
            continue
        fi

        # Accumulate total duration
        total_seconds=$((total_seconds + duration))

        # Convert duration to hh:mm:ss format
        hours=$((duration / 3600))
        minutes=$(((duration % 3600) / 60))
        seconds=$((duration % 60))
        duration_str=$(printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds")

        # Write the formatted name and duration to the temporary file
        echo -e "\t$(truncate_name "$(basename "$item")")\t$duration_str" >> "$temp_file"
    done

    # Print the table
    column -s $'\t' -t < "$temp_file"

    # Format total duration intelligently
    hours=$((total_seconds / 3600))
    minutes=$(((total_seconds % 3600) / 60))
    seconds=$((total_seconds % 60))

    total_duration=""
    if [ "$hours" -gt 0 ]; then
        total_duration="$hours hour"
        [ "$hours" -gt 1 ] && total_duration="${total_duration}s"
    fi
    if [ "$minutes" -gt 0 ]; then
        [ -n "$total_duration" ] && total_duration="$total_duration, "
        total_duration="$total_duration$minutes minute"
        [ "$minutes" -gt 1 ] && total_duration="${total_duration}s"
    fi
    if [ "$seconds" -gt 0 ]; then
        [ -n "$total_duration" ] && total_duration="$total_duration, "
        total_duration="$total_duration$seconds second"
        [ "$seconds" -gt 1 ] && total_duration="${total_duration}s"
    fi

    # Print total duration
    echo -e "\nTotal Duration: $total_duration\n"

    # Remove temporary file
    rm -f "$temp_file"
}
