# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
export PATH="$HOME/.cargo/bin:$PATH"
# Make an alias for invoking commands you use constantly
# alias p='python'

# opencode
export PATH=/home/shaaux/.opencode/bin:$PATH

set -h

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/shaaux/anaconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/home/shaaux/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/home/shaaux/anaconda3/etc/profile.d/conda.sh"
  else
    export PATH="/home/shaaux/anaconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# <<< conda initialize <<<
