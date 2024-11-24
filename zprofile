# Load terminal environment variables
if [ -f ~/.terminal_config/.env ]; then
    source ~/.terminal_config/.env
fi

# Add Homebrew environment
eval $(/usr/local/Homebrew/bin/brew shellenv) #ckbrew

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
