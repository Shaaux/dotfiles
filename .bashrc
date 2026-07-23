# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
export PATH="$HOME/.cargo/bin:$PATH"
# Make an alias for invoking commands you use constantly
# alias p='python'
alias lg='lazygit'
alias y='yazi'
alias oc='opencode'
alias ca='claude'
alias cac='claude --continue'

# opencode
export PATH=/home/shaaux/.opencode/bin:$PATH

set -h

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
. "$HOME/.cargo/env"
