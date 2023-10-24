if command -v pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# Prefix PS1 with the virtualenv name if we've activated one 
# https://github.com/pyenv/pyenv-virtualenv/issues/268
function pyenv_ps1 {
    python_version=$(pyenv version | awk 'NR==1')
    if ! echo "${python_version}" | grep -Eq "set by.*\.pyenv/version"; then
        python_version=$(echo "${python_version}" | awk '{printf("%s", $1)}')
        printf "(%s) " "${python_version}"
        #echo -n "(${python_version}) "
    fi
}

export PS1="\[\033[0;37m\]\u@\h\[\033[0;32m\] \w \$\[\033[00m\] "
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
alias vim='nvim'

# Add tailf on macOS
if [ $(uname -s | tr [A-Z] [a-z]) == "darwin" ]
then
    alias tailf='tail -f'
fi

if [ -d ~/bin ]
then
    export PATH="${HOME}/bin:${PATH}"
fi

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -d /usr/local/opt/mysql@5.7/bin ] 
then
    export PATH="$PATH:/usr/local/opt/mysql@5.7/bin"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# OpenJDK - For compilers to find openjdk you may need to set:
if [[ -d /usr/local/opt/openjdk@11 ]]; then
    export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"
fi
# export CPPFLAGS="-I/usr/local/opt/openjdk/include"

export CLOUDSDK_PYTHON=python3

export PATH="$PATH:/usr/local/opt/node@14/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/platform-tools"
