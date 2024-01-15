# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091
SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

export BASH_SILENCE_DEPRECATION_WARNING=1

export HISTTIMEFORMAT="%F %T  "
export EDITOR="nvim"
export HISTSIZE=-1

export PYENV_ROOT="${HOME}/.pyenv"
[[ -d "${PYENV_ROOT}" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"

if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

if command -v pyenv-virtualenv-init >/dev/null 2>&1; then
    eval "$(pyenv virtualenv-init -)"
fi

[[ -f ~/.adbrc ]] && source ~/.adbrc

case "${SYSTEM_OS}" in
darwin)
    [[ -f "${HOME}/.bash_profile-macos" ]] && source "${HOME}/.bash_profile-macos"
    ;;
linux)
    [[ -f "${HOME}/.bash_profile-linux" ]] && source "${HOME}/.bash_profile-linux"
    ;;
*) ;;
esac

[[ -f ~/.bashrc ]] && source ~/.bashrc
# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[[ -e ~/.global.env ]] && source ~/.global.env
