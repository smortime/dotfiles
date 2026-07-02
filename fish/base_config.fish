set -gx EDITOR nvim

# User paths (machine-local, kept out of fish_user_paths sync)
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/sqlite/bin

# Aliases
alias vim nvim
alias vi nvim
alias ll="eza -la"
alias pv="source .venv/bin/activate.fish"

# Helpful functions...
function gac
    git add .
    git commit -m "$argv"
end

# Shell prompt
starship init fish | source
# z alternative
zoxide init fish | source
