# shellcheck shell=bash
SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

# Global stuff independent of which OS we're running on
if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
fi

# Prefix PS1 with the virtualenv name if we've activated one
# https://github.com/pyenv/pyenv-virtualenv/issues/268
function pyenv_ps1 {
    python_version=$(pyenv version | awk 'NR==1')
    if ! echo "${python_version}" | grep -Eq "set by.*\.pyenv/version"; then
        python_version=$(echo "${python_version}" | awk '{printf("%s", $1)}')
        printf "(%s) " "${python_version}"
    fi
}

# Dynamically update PS1 to include a pyenv virtualenv, if present
if command -v pyenv >/dev/null; then
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export -f pyenv_ps1
    export PROMPT_COMMAND='pyenv_ps1'
fi

export CLICOLOR=1

shopt -s histappend

alias ls='ls -a'
alias ll='ls -ahl'
alias rm='rm -i'

[[ -d ~/bin ]] && export PATH="${HOME}/bin:${PATH}"

export CLOUDSDK_PYTHON=python3

case "${SYSTEM_OS}" in
darwin)
    # shellcheck disable=SC1091
    [[ -e "${HOME}/.bashrc-macos" ]] && source "${HOME}/.bashrc-macos"
    ;;
linux)
    # shellcheck disable=SC1091
    [[ -e "${HOME}/.bashrc-linux" ]] && source "${HOME}/.bashrc-linux"
    ;;
*) ;;
esac
