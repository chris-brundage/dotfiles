SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

# Get pyenv's shell stuff going. 
setup_pyenv ()
{
    if command -v pyenv >/dev/null 2>&1; then
        export PYENV_ROOT="$HOME/.pyenv"
        [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
}

setup_pyenv

# Python 3 support for gcloud
export CLOUDSDK_PYTHON=python3

case "${SYSTEM_OS}" in
    darwin) 
        [[ -f "${HOME}/.zprofile-macos" ]] && source "${HOME}/.zprofile-macos"
    ;;
    linux)
        [[ -f "${HOME}/.zprofile-linux" ]] && source "${HOME}/.zprofile-linux"
    ;;
    *) 
    ;;
esac

# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[[ -e ~/.global.env ]] && source ~/.global.env
