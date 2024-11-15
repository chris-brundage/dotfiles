#compdef gitlab-ci-local
###-begin-gitlab-ci-local-completions-###
#
# yargs command completion script
#
# Installation: gitlab-ci-local completion >> ~/.zshrc
#    or gitlab-ci-local completion >> ~/.zprofile on OSX.
#
_gitlab-ci-local_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gitlab-ci-local --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}

if command -v gitlab-ci-local &>/dev/null; then
    compdef _gitlab-ci-local_yargs_completions gitlab-ci-local
fi
###-end-gitlab-ci-local-completions-###

