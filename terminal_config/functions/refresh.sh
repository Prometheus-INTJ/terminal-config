# ================================================
# Function: refresh
# ================================================
# Description:
# This function reloads the shell configuration files (`~/.zshrc` and `~/.bash_profile`)
# if they exist, ensuring any recent changes take effect without restarting the shell.
#
# Features:
# - Dynamically checks for the existence of configuration files.
# - Supports both `zsh` and `bash` environments.
#
# Usage:
# - refresh
#   - Reloads the appropriate configuration files based on your shell environment.
#
# Notes:
# - Ensure your configuration files are located at `~/.zshrc` or `~/.bash_profile`.
# - No need to restart the shell for changes to take effect after running this command.
#
# ================================================

refresh() {
    # Get the current username and hostname
    username=$(whoami)                      # Current username
    hostname=$(hostname | cut -d'.' -f1)    # Hostname (without domain part)

    # Generate the dynamic prompt prefix
    prompt_prefix="${username}@${hostname} $(pwd | sed "s|^$HOME|~|") %"

    # Detect the current shell type using 'ps'
    current_shell=$(ps -p $$ -o comm= | sed 's/^-//')  # Remove leading '-' if present

    # Use case structure to handle different shell types
    case "$current_shell" in
        zsh)
            if [ -f ~/.zshrc ]; then
                source ~/.zshrc
                echo "${prompt_prefix} source ~/.zshrc"
            fi
            ;;
        bash)
            if [ -f ~/.bash_profile ]; then
                source ~/.bash_profile
                echo "${prompt_prefix} source ~/.bash_profile"
            fi
            ;;
        *)
            echo "${prompt_prefix} Unsupported shell: $current_shell"
            ;;
    esac
}
