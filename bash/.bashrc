# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'

# Start the ssh-agent and add ssh.
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Use bat to read manpages.
export MANPAGER="nvim +Man!"


# Created by `pipx` on 2026-01-12 20:16:13
export PATH="$PATH:/home/drew/.local/bin"
alias hx="helix"
