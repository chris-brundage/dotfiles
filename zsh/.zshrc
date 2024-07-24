SYSTEM_OS="$(uname -s | tr '[:upper:]' '[:lower:]')"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gentoo"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
ZSH_CUSTOM="${HOME}/.oh-my-zsh-custom"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

case "${SYSTEM_OS}" in
    darwin)
        plugins=(git direnv safe-paste iterm2)
        # Home brew autocompletion stuff needs to happen before we source oh my zsh
        if command -v brew &>/dev/null; then
            FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

            if [[ -d "$(brew --prefix)/share/zsh-completions" ]]; then
                FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"
            fi
        fi
    ;;
    linux)
        plugins=(git direnv safe-paste)
    ;;
    *) 
    ;;
esac

source $ZSH/oh-my-zsh.sh

# Prevent shell completion from chopping off spaces before & and |
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# I disagree with some of oh-my-zsh's opinions
unsetopt sharehistory

# Keep bash style behavior for ^U
bindkey \^U backward-kill-line

alias ls='ls -a' 
alias ll='ls -ahl'
alias rm='rm -i'

export EDITOR="nvim"
export CLICOLOR=1
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# Use pyenv to activate the provided virtual environment name
activate_venv ()
{
    venv_name="${1}"
    if [[ -z "${venv_name}" ]]; then
        printf "A virtual environment name is required.\n"
    fi

    if command -v pyenv >/dev/null 2>&1; then
        pyenv_version=$(pyenv version)

        if [[ "${pyenv_version}" != $venv_name* && "${pyenv_version}" != *PYENV_VERSION* ]]; then
            # Don't fail the cd on account of the virtualenv not existing. pyenv will let us know
            pyenv activate $venv_name || true
        elif [[ "${pyenv_version}" != $venv_name* ]]; then
            printf "Deactivating virtualenv %s\n" $pyenv_version
            pyenv deactivate || true
            pyenv activate $venv_name || true
        fi
    else
        printf "It looks like pyenv is not installed. You should probably fix that.\n"
    fi
}

case "${SYSTEM_OS}" in
    darwin)
        [[ -f "${HOME}/.zshrc-macos" ]] && source "${HOME}/.zshrc-macos"
    ;;
    linux)
        [[ -f "${HOME}/.zshrc-linux" ]] && source "${HOME}/.zshrc-linux"
    ;;
    *) 
    ;;
esac

load_env_file ()
{
    env_file="${1}"

    # https://gist.github.com/mihow/9c7f559807069a03e302605691f85572?permalink_comment_id=4172996#gistcomment-4172996
    # People on the internet are much smarter than I am
    set -o allexport
    source "${env_file}"
    set +o allexport
}

# 
# Begin work specific stuff
#
cdastro ()
{
    activate_venv astro
    cd ~/src/bi-astronomer
}

cddbt ()
{
    activate_venv astro
    cd ~/src/bi-astronomer/dags/dbt
}

# Load secret envrionment variables so I don't foolishly put them in a public git repo!
[[ -e "${HOME}/.global.env" ]] && load_env_file "${HOME}/.global.env"
