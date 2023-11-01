# Home brew stuff. My personal laptop doesn't need this for some reason
[ -d /opt/homebrew/bin ] && export PATH="/opt/homebrew/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="/usr/local/opt/redis/bin:$PATH"
# Python 3 support for gcloud
export CLOUDSDK_PYTHON=python3

export PATH="/opt/snowflake/snowcd:$PATH"
export PATH="/Applications/SnowSQL.app/Contents/MacOS:$PATH"

# Go stuff
export GOPATH=$HOME/src/go
export PATH="$PATH:$GOPATH"
export PATH="${PATH}:${GOPATH}/bin"

# The macOS version of sed is trash
if [[ $(uname) == "Darwin" ]]; then
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:${PATH}"
fi

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
