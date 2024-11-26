# ================================================
# Function: edit_config
# ================================================
# Description:
# This function allows the user to edit different configuration files, 
# such as environment variables, aliases, or specific function files, 
# through an interactive menu.
#
# Features:
# - Provides a user-friendly menu to select the file type to edit.
# - Dynamically lists available function files in the functions directory.
# - Opens the selected file in the `vim` editor.
# - Validates the existence of files and directories before editing.
# - Displays clear error messages for invalid selections or missing files.
#
# Dependencies:
# - `vim` editor: Used to edit configuration files.
# - Shell support for user input and dynamic file handling.
#
# Usage:
# - edit_config
#   - Launches the interactive menu.
#   - Prompts the user to select one of the following:
#     1) Environment Variables
#     2) Aliases
#     3) Functions (lists available files for selection)
#   - Opens the corresponding file in `vim` for editing.
#
# Notes:
# - Ensure that the configuration files (e.g., aliases, env) and functions directory exist.
# - If function files are dynamically added or removed, the menu will reflect the changes.
# - This function does not save changes automatically; remember to save in `vim` before exiting.
# ================================================

edit_config() {
    local base_dir="/Users/zhangyipu/.terminal_config"
    local func_dir="$base_dir/functions"
    local aliases_file="$base_dir/aliases"
    local env_file="$base_dir/env"

    # Display options to the user
    echo "Select what you want to edit:"
    echo "1) Environment Variables"
    echo "2) Aliases"
    echo "3) Functions"

    # Prompt the user to make a selection
    echo -n "Enter your choice (1/2/3): "
    read choice

    case $choice in
        1)
            # Edit environment variables file
            if [ -f "$env_file" ]; then
                vim "$env_file"
            else
                echo "Environment variables file not found: $env_file"
            fi
            ;;
        2)
            # Edit aliases file
            if [ -f "$aliases_file" ]; then
                vim "$aliases_file"
            else
                echo "Aliases file not found: $aliases_file"
            fi
            ;;
        3)
            # Edit a function file
            if [ -d "$func_dir" ]; then
                cd "$func_dir" || { echo "Failed to access $func_dir"; return 1; }
                echo "Available functions:"
                ls "$func_dir"
                echo -n "Enter the function name to edit: "
                read func_name
                if [ -f "$func_dir/$func_name" ]; then
                    vim "$func_dir/$func_name"
                else
                    echo "Function file '$func_name' not found!"
                fi
            else
                echo "Functions directory not found: $func_dir"
            fi
            ;;
        *)
            # Invalid choice handling
            echo "Invalid choice! Please enter 1, 2, or 3."
            ;;
    esac
}
