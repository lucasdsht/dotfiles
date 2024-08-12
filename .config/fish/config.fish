if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ll 'exa -l --icons'
alias lla "ll -a"
alias vim "nvim"
alias cat "bat"
alias rm 'rm -i'
alias cp 'cp -i'
alias mv 'mv -i'

# path variables
set -x PATH $PATH /home/lucasdcht/.local/bin
set -x PATH $PATH /home/lucasdcht/go/bin
set -x PATH $PATH /home/lucasdcht/.cargo/bin
# custom keybindings
bind \cS "tmux-sessionizer"

# set nvm default version
set --universal nvm_default_version lts


# pnpm
set -gx PNPM_HOME "/home/lucasdcht/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end



# neofetch at startup
if not set -q TMUX
    neofetch
end

# starship stuff

# Set Starship configuration file
set -x STARSHIP_CONFIG ~/.config/starship/starship.toml

# Initialize Starship prompt
starship init fish | source
