# Are we ARM or Intel?
os_arch=$(uname -m)

# Figure out where homebrew lives (if installed) and get PATH and such updated
setup_homebrew ()
{
    if [[ "${os_arch}" == "arm64" ]]; then
        brew_path="/opt/homebrew"
    else
        brew_path="/usr/local"
    fi

    if [[ -d "$brew_path" ]]; then
        brew_cmd="${brew_path}/bin/brew"
        eval "$($brew_cmd shellenv)" >/dev/null
    fi
}

# Get pyenv's shell stuff going. 
setup_pyenv ()
{
    if command -v pyenv >/dev/null 2>&1; then
        export PYENV_ROOT="$HOME/.pyenv"
        [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
}

setup_homebrew
setup_pyenv

[[ -d /usr/local/opt/redis/bin ]] && export PATH="/usr/local/opt/redis/bin:$PATH"
# Python 3 support for gcloud
export CLOUDSDK_PYTHON=python3

export PATH="/opt/snowflake/snowcd:$PATH"
export PATH="/Applications/SnowSQL.app/Contents/MacOS:$PATH"

# Go stuff
export GOPATH=$HOME/src/go
export PATH="$PATH:$GOPATH"
export PATH="${PATH}:${GOPATH}/bin"

# Optional homebrew installed software that lives outside Homebrew's PATH
if [[ -n "$HOMEBREW_PREFIX" ]]; then
    # The macOS version of sed is trash
    sed_path="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin"
    [[ -d "$sed_path" ]] &&  export PATH="${sed_path}:${PATH}"

    [[ -d "${HOMEBREW_PREFIX}/opt/mysql@8.0/bin" ]] && export PATH="${HOMEBREW_PREFIX}/opt/mysql@8.0/bin:$PATH"
fi

# VSCode...I have to use it for some projects at work. Sad :(
[[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[[ -e ~/.global.env ]] && source ~/.global.env
