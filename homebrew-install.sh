#!/usr/bin/env bash
if [[ ! "$(uname -s)" == "Darwin" ]]; then
    printf "This script is only meant for macOS systems\n"
    exit 1
fi

MACOS_ARCH=$(uname -m)

# Figure out what login shell (and therefore profile file) the user is using
if [[ "${SHELL}" == "/bin/zsh" ]]; then
    PROFILE_FILE="${HOME}/.zprofile"
elif [[ "${SHELL}" == *bash* ]]; then
    PROFILE_FILE="${HOME}/.bash_profile"
else
    printf "Shell %s is not supported by this script!\n" "${SHELL}"
    exit 1
fi

install_packages() {
    [[ -e "homebrew-packages.txt" ]] && xargs brew install <"homebrew-packages.txt"
}

install_casks() {
    [[ -e "homebrew-casks.txt" ]] && xargs brew tap <"homebrew-casks.txt"
}

setup_homebrew() {
    if ! command -v brew >/dev/null 2>&1; then
        install_homebrew

        if [[ "${MACOS_ARCH}" == "x86_64" ]]; then
            brew_path="/usr/local/bin"
        else
            brew_path="/opt/homebrew/bin"
        fi
    else
        brew_path="$(brew --prefix)/bin"
    fi

    if ! env | grep -q "${brew_path}"; then
        # shellcheck disable=SC1090
        source "${PROFILE_FILE}"
    fi
}

install_homebrew() {
    if ! command -v brew &>/dev/null; then
        printf "Install Homebrew\n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

# Install macOS developer tools if necessary
xcode_install() {
    if ! command -v git >/dev/null 2>&1; then
        printf "Developer tools are not installed. Installing them now!\n"
        sleep 5

        sudo xcode-select --install
    fi
}

xcode_install
setup_homebrew
install_casks
install_packages

printf "Successfully installed homebrew\n"
