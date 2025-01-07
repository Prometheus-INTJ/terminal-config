# ================================================
# Function: convert_to_mp4
# ================================================
# Description:
# Converts video files (.ts, .mkv, etc.) to MP4 format without re-encoding.
#
# Features:
# - Supports batch processing of multiple input files.
# - Retains the original file's video and audio streams (no re-encoding).
# - Automatically names the output file based on the input filename.
#
# Dependencies:
# - ffmpeg: Required for video conversion.
#
# Usage:
# - Single file: convert_to_mp4 input_file
# - Multiple files: convert_to_mp4 input_file1 input_file2 ...
#
# Example:
# - Single file:
#   convert_to_mp4 input.mkv
#   Output: input.mp4
#
# - Multiple files:
#   convert_to_mp4 input1.mkv input2.ts
#   Outputs: input1.mp4, input2.mp4
#
# Notes:
# - If the output file already exists, it will be overwritten.
#
# ================================================

convert_to_mp4() {
    HISTFILE=/dev/null

    if [ "$#" -eq 0 ]; then
        echo "Please provide at least one input file!"
        return 1
    fi

    for input_file in "$@"; do
        if [ ! -f "$input_file" ]; then
            echo "File not found: $input_file"
            continue
        fi

        # Get the directory and base name of the input file
        source_dir=$(dirname "$input_file")
        base_name=$(basename "$input_file" | sed 's/\.[^.]*$//')

        # Construct the output file path in the source directory
        output_file="$source_dir/$base_name.mp4"

        # Perform the conversion
        echo "Converting '$input_file' to '$output_file'..."
        ffmpeg -i "$input_file" -c copy "$output_file"

        # Check if the conversion succeeded
        if [ $? -eq 0 ]; then
            echo "Conversion successful: $output_file"
        else
            echo "Conversion failed: $input_file"
        fi
    done
}

# Alias for quick access
alias c2mp4='convert_to_mp4'
