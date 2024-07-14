#!/usr/bin/env bash

export EDITOR=nvim

export CDPATH=".:~/files/:~/files/vysoka_skola/s6"

# Aliases
alias la='ls -la --color=auto'
alias xo='xdg-open'
alias dbx='distrobox'
alias dbxe='distrobox enter "$( distrobox list | tail -n +2 | cut -d " " -f3 | fzf-tmux )"'
alias cpcf='cp ~/.clang-format .'
alias cld='wl-paste >'
alias cldi='wl-paste > input'
alias lnd='curl "$( wl-paste )" -O'
alias lndo='curl "$( wl-paste )" -o'

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
[[ -d "$PYENV_ROOT/bin" ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Python debugger
export PYTHONBREAKPOINT='pudb.set_trace'

# Vi mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Launch Tmux in default session on shell startup 
if [[ "$TERM" != 'tmux-256color' ]]; then
    tmux attach -t 'personal' || tmux new -s 'personal' -n 'shell'
fi
