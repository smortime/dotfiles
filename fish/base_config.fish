set -gx EDITOR nvim

# Color scheme (declarative, replaces machine-local fish_variables sync)
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel -r
set -g fish_color_command normal
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end green
set -g fish_color_error brred
set -g fish_color_escape brcyan
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_normal normal
set -g fish_color_operator brcyan
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection cyan --bold
set -g fish_color_search_match white --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r

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
