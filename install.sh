#!/bin/bash
SRC="${1:-${HOME}/src/dotfiles}"

# These are not true dotfiles (e.g. iTerm settings), but it's nice to have them
# in the repo. Packages in this array will be kept away from stow
excluded_packages=(
    iterm
)

find_cmd=(
    "find" "${SRC}"
    "!" "-path" "${SRC}"
    "-maxdepth" "1"
    "-type" "d"
    "-not" "-name" ".git"
    "-and" "-not" "-name" "."
)

# bash makes me want to barf sometimes
# I also probably over engineered the hell out of this given how few symlink
# packages we care about
read -r -a exclude_args <<<"${excluded_packages[@]/#/-and -not -name }"
find_cmd+=("${exclude_args[@]}")
find_cmd+=("-exec" "basename" "{}" "\\" ";")

# Get all directories inside source dir, except the dir itself and .git, and stow things
packages=$("${find_cmd[@]}")
# shellcheck disable=SC2250
for package in $packages; do
    printf "Stowing %s\n" "${package}"

    stow -R --target="${HOME}" "${package}" 2>/dev/null
done
