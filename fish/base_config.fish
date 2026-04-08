set -gx EDITOR nvim

# Aliases
alias vim nivm
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
