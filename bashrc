export PS1="\\n\\w\\n\\$ "
export HISTCONTROL=ignoreboth:erasedups

alias reload="exec $SHELL -l"
alias autoraise="/Applications/AutoRaise"

alias gs="git status -u"

# asdf
test -r ~/.asdf/asdf.sh && . ~/.asdf/asdf.sh
test -r ~/.asdf/completions/asdf.bash && . ~/.asdf/completions/asdf.bash

# enhancd
test -r ~/enhancd/init.sh && . ~/enhancd/init.sh
ENHANCD_HYPHEN_ARG=--
ENHANCD_DOT_ARG="..."
ENHANCD_DISABLE_HOME=1
