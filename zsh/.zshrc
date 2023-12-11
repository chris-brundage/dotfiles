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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew pyenv ripgrep safe-paste iterm2)

source $ZSH/oh-my-zsh.sh

alias ls='ls -a' 
alias ll='ls -ahl'
alias rm='rm -i'
alias vim='nvim'

export EDITOR="nvim"
export CLICOLOR=1
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

[ -d /usr/local/opt/mysql@8.0/bin ] && export PATH="/usr/local/opt/mysql@8.0/bin:$PATH"

#
# Begin Work stuff
#

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

# Activate the astro virtual environment (if needed) and switch to the source dir
cdastro ()
{
    activate_venv astro && cd ~/src/bi-astronomer
}

# Activate the dbt virtual environment (if needed) and switch to the source dir
cddbt ()
{
   activate_venv dbt && cd ~/src/bi-astronomer/dags/dbt
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chris.brundage/src/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/chris.brundage/src/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chris.brundage/src/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/chris.brundage/src/google-cloud-sdk/completion.zsh.inc'; fi

# Ruby!
[ -d /opt/homebrew/opt/ruby@3.1/bin ] && export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"

#
# End Work stuff
#

# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

