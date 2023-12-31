#!/bin/bash
SRC="${1:-${HOME}/src/dotfiles}"

# Get all directories inside source dir, except the dir itself and .git, and stow things
find "${SRC}" ! -path "${SRC}" -maxdepth 1 -type d -not -name .git -and -not -name . -exec basename {} \; | while read -r stow_dir; do
    printf "Stowing %s\n" "${stow_dir}"

    stow -R --target="$HOME" "${stow_dir}"
done
