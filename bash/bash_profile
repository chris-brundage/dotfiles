export BASH_SILENCE_DEPRECATION_WARNING=1

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv > /dev/null; then
    eval "$(pyenv init --path)"
fi

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

if [ -f ~/.novarc ]; then
	. ~/.novarc
fi

if command -v brew > /dev/null; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

export HISTTIMEFORMAT="%F %T  "
export EDITOR="nvim"
export HISTSIZE=-1
export BASH_SILENCE_DEPRECATION_WARNING=1

export PATH="/usr/local/sbin:$PATH"
#eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

if [ -f ~/.adbrc ]; then
    . ~/.adbrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chris/lib/google-cloud-sdk/path.bash.inc' ]; then . '/Users/chris/lib/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chris/lib/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/chris/lib/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/opt/openjdk@11/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
