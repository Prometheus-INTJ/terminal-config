# ================================================
# Function: make_iso
# ================================================
# Description:
# Creates an ISO file from a specified folder using hdiutil.
# The ISO will be saved in the same directory as the input folder,
# with a default or user-specified name.
#
# Usage:
# - make_iso <folder_path> [iso_name]
#
# Example:
# - make_iso /path/to/folder
#   -> Output: /path/to/folder_backup.iso
#
# - make_iso /path/to/folder MyISO.iso
#   -> Output: /path/to/MyISO.iso
#
# ================================================

make_iso() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: create_iso <folder_path> [iso_name]"
        return 1
    fi

    # Get the folder path and validate
    folder_path="$1"
    if [ ! -d "$folder_path" ]; then
        echo "Error: Folder not found: $folder_path"
        return 1
    fi

    # Get the base name of the folder
    base_name=$(basename "$folder_path")

    # Determine output ISO name
    if [ "$#" -eq 2 ]; then
        # If user specifies an ISO name
        iso_name="$2"
    else
        # Default to folder_name_backup.iso
        iso_name="${base_name}_backup.iso"
    fi

    # Construct full output path
    output_path=$(dirname "$folder_path")/"$iso_name"

    # Create the ISO file using hdiutil
    echo "Creating ISO from folder '$folder_path'..."
    hdiutil makehybrid -o "$output_path" "$folder_path" -iso

    # Check if ISO creation was successful
    if [ $? -eq 0 ]; then
        echo "ISO created successfully: $output_path"
    else
        echo "Failed to create ISO from folder: $folder_path"
    fi
}
