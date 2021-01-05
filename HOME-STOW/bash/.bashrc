#
# ~/.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set +x 

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -x "$(command -v cargo)" ]; then
  export PATH=${PATH}:"$HOME/.cargo/bin"
fi

if [ -x "$(command -v go)" ]; then
    export GOPATH="$HOME/.local/go"
    export GOBIN="$HOME/.local/bin"
fi

# Powerline Configuration
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

PROMPT_COMMAND=
if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_powerline_status_wrapper _powerline_set_prompt $PROMPT_COMMAND"
fi

# Bash History Configuration
# avoid duplicates
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
#After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"


# Bash Completions: include all additional custom bash completion scripts
LOCAL_BASH_COMPLETIONS="$HOME/.local/share/bash-completion/completions/*"
for f in $LOCAL_BASH_COMPLETIONS; do
    # shellcheck source=/dev/null
    . "$f"
done

##############################################
# ALIASES
##############################################
# Nice pastebin util
alias pb="curl -F 'f:1=<-' ix.io"
# The silver searcher and ignore ctag files
alias ag='ag --ignore=tags --pager="less -XFR"'
alias cclip="xclip -selection clipboard"
alias ls='ls --color=auto'
alias ll="ls -la"

export PATH=${PATH}:"$HOME/.local/bin":"$HOME/Desktop/"
export EDITOR=nvim
export SYSTEMD_EDITOR=nvim
export DOTFILE_DIR=$HOME/dotfiles/
export TERM=xterm-256color

##############################################
# Bash AUX
# Custom Bash Scripts (self-maintained)
##############################################
BASHAUX_DIR="$HOME/.bashaux"
if [ -d "$BASHAUX_DIR" ]; then
    BASHAUX=$BASHAUX_DIR/*
    for f in $BASHAUX; do
        # shellcheck source=/dev/null
        . "$f"
    done
fi
