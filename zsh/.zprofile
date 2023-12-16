if command -v brew >/dev/null 2>&1; then
    eval "$(brew shellenv)" >/dev/null
fi

if command -v pyenv >/dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

[[ -d /usr/local/opt/redis/bin ]] && export PATH="/usr/local/opt/redis/bin:$PATH"
# Python 3 support for gcloud
export CLOUDSDK_PYTHON=python3

export PATH="/opt/snowflake/snowcd:$PATH"
export PATH="/Applications/SnowSQL.app/Contents/MacOS:$PATH"

# Go stuff
export GOPATH=$HOME/src/go
export PATH="$PATH:$GOPATH"
export PATH="${PATH}:${GOPATH}/bin"

# The macOS version of sed is trash
if [[ -n "$HOMEBREW_PREFIX" ]]; then
    export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:${PATH}"

    [[ -d "${HOMEBREW_PREFIX}/opt/mysql@8.0/bin" ]] && export PATH="${HOMEBREW_PREFIX}/opt/mysql@8.0/bin:$PATH"
fi

[[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[[ -e ~/.global.env ]] && source ~/.global.env
