# shellcheck shell=bash
SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

case "${SYSTEM_OS}" in
darwin)
    [[ -f "${HOME}/.bash_logout-macos" ]] && source "${HOME}/.bash_logout-macos"
    ;;
linux)
    [[ -f "${HOME}/.bash_logout-linux" ]] && source "${HOME}/.bash_logout-linux"
    ;;
*) ;;
esac
