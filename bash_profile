# Load terminal environment variables
if [ -f ~/.terminal_config/.env ]; then
    source ~/.terminal_config/.env
fi

# Load terminal aliases
if [ -f ~/.terminal_config/.aliases ]; then
    source ~/.terminal_config/.aliases
fi

# Load terminal functions
if [ -f ~/.terminal_config/.functions ]; then
    source ~/.terminal_config/.functions
fi
