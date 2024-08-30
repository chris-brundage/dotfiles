SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

# Linux handles this automatically, but I assume macOS doesn't since it hates freedom
export XDG_CONFIG_HOME="${HOME}/.config"

# We need this global because pyenv on macOS fucks up without doing homebrew stuff
# Figure out where homebrew lives (if installed) and get PATH and such updated
setup_homebrew ()
{
    # Are we ARM or Intel?
    os_arch=$(uname -m)

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

#
# We need this global because pyenv on macOS fucks up without doing homebrew stuff
[[ "${SYSTEM_OS}" == "darwin" ]] && setup_homebrew
setup_pyenv

[[ -d "${HOME}/bin" ]] && export PATH="${HOME}/bin:${PATH}"
[[ -d "${HOME}/scripts" ]] && export PATH="${HOME}/scripts:${PATH}"

# Rust
[[ -d "${HOME}/.cargo/bin" ]] && export PATH="${HOME}/.cargo/bin:${PATH}"

# Python 3 support for gcloud
export CLOUDSDK_PYTHON=python3
