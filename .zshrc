export LANG=en_US.UTF-8
export EDITOR=vim
export PAGER=less
export GOKU_EDN_CONFIG_FILE="$HOME/.config/karabiner/karabiner.edn"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openldap/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

PROMPT="%~ %# "
bindkey -d
bindkey -e
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

alias reload="exec $SHELL -l"
alias ls="exa -lF"
alias lsa="exa -laF"
alias lt="exa -TF"
alias lta="exa -TaF"

# (b)rew (i)nstall (f)ormula with fzf
bif() {
  local inst=$(brew search | fzf -m)

  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# (b)rew (i)nstall (c)ask with fzf
bic() {
  local token
  token=$(brew search --cask | fzf-tmux --query="$1" +m --preview 'brew info --cask {}')

  if [ "x$token" != "x" ]
  then
    echo "(I)nstall or open the (h)omepage of $token"
    read input
    if [ $input = "i" ] || [ $input = "I" ]; then
      brew install --cask $token
    fi
    if [ $input = "h" ] || [ $input = "H" ]; then
      brew cask home $token
    fi
  fi
}

# asdf install
test -r $HOME/.asdf/asdf.sh && . $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit
