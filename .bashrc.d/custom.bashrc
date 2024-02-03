#!/usr/bin/env bash

export EDITOR=nvim

# Aliases
alias la='ls -la --color=auto'

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
