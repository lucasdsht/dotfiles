if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ll 'exa -l --icons'
alias lla "ll -a"
alias vim "nvim"

# path variables

set -x PATH $PATH /home/lucasdcht/.local/bin

# ARIA venv path
set VIRTUAL_ENV "/home/lucasdcht/Dev/ARIA/venv/myenv"


# custom keybindings
bind \cS "tmux-sessionizer"


# set nvm default version
set --universal nvm_default_version lts
