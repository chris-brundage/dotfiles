# shellcheck disable=all
SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

case "${SYSTEM_OS}" in
darwin)
    [[ -f "${HOME}/.zlogout-macos" ]] && source "${HOME}/.zlogout-macos"
    ;;
linux)
    [[ -f "${HOME}/.zlogout-linux" ]] && source "${HOME}/.zlogout-linux"
    ;;
*) ;;
esac

# vim: set ft=sh:
