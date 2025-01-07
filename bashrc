# Prefer the latest version of Bash
export PATH="/usr/local/bin:$PATH"

# Load terminal environment variables
if [ -f ~/.terminal_config/env ]; then
    source ~/.terminal_config/env
fi

# Load terminal functions
for file in ~/.terminal_config/functions/*; do
    [ -f "$file" ] && source "$file"
done

# Load terminal aliases
if [ -f ~/.terminal_config/aliases ]; then
    source ~/.terminal_config/aliases
fi
