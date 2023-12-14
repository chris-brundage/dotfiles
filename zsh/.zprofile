uname=($(uname -s -m))
# zsh is a monster for not counting from 0
os="${uname[1]}"
arch="${uname[2]}"

if [[ "${arch}" == "x86_64" ]]; then
    homebrew_path="/usr/local"
else
    homebrew_path="/opt/homebrew"
fi

# Set homebrew path with support for x86 and ARM
set_homebrew_path ()
{
    if command -v "${homebrew_path}/bin/brew" >/dev/null 2>&1; then
        eval "${homebrew_path}/bin/brew shellenv" >/dev/null
    fi
}

set_homebrew_path

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
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
if [[ "${os}" == "Darwin" ]]; then
    export PATH="${homebrew_path}/opt/gnu-sed/libexec/gnubin:${PATH}"
fi

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

[[ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[ -e ~/.global.env ] && source ~/.global.env
