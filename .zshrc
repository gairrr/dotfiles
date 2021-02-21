export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openldap/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# zsh prompt
PROMPT="%~ %# "
# use emacs keybindings
bindkey -e
# completion settings (ignore case)
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

setopt hist_ignore_dups

### ALIASES ###

# reload shell
alias reload="exec $SHELL -l"

# use exa instead of ls
alias ls="exa -lF --group-directories-first"
alias lsa="exa -laF --group-directories-first"
alias lt="exa -TF --group-directories-first"
alias lta="exa -TaF --group-directories-first"

# add flags
alias mv="mv -vi"
alias cp="cp -vi"
alias rm="gomi"

# navigation
alias ..="\\cd .."
alias ...="\\cd ../.."
alias .3="\\cd ../../.."
alias .4="\\cd ../../../.."
alias .5="\\cd ../../../../.."

### ASDF ###

. $HOME/.asdf/asdf.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

### enhancd ###

source ~/enhancd/init.sh

