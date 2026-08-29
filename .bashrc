# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
# /etc/omarchy.conf is written by omarchy-dev-link. When absent, force the
# package default instead of preserving a stale inherited dev-link value before
# we decide which rc file to source.
if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"
else
  export OMARCHY_PATH=/usr/share/omarchy
fi
source "$OMARCHY_PATH/default/bash/rc"

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

# Per-machine overrides that shouldn't be shared across machines (e.g. Unity
# CLI's PATH entry, which only exists on the laptop). Not tracked in git;
# see .bashrc.local.example.
[[ -f "$HOME/.bashrc.local" ]] && source "$HOME/.bashrc.local"
