#!/usr/bin/env bash

echo "Setting up dev environment"
echo -e "\nCreating symlinks...\n"

for i in nvim alacritty zellij; do
  ln -sfn $PWD/$i ~/.config/$i
  echo "Symlinked: $i"
done

echo -e "\nDone creating symlinks\n"

echo -e "\nSetting up fish\n"
if [ ! -d "$HOME/.config/fish" ]; then
  mkdir "$HOME/.config/fish"
  echo "Created fish directory"
fi

ROOT_FISH=$HOME/.config/fish/config.fish
touch $ROOT_FISH
FISH_BASE=$PWD/fish/base_config.fish
LINE_TO_ADD="source $FISH_BASE"

if ! grep -qFx "$LINE_TO_ADD" "$ROOT_FISH"; then
  echo -e "\n$LINE_TO_ADD" >>$ROOT_FISH
  echo "Added base_config source to $ROOT_FISH"
else
  echo "base_config already sourced in $ROOT_FISH"
fi

FUNCTIONS_DIR=$HOME/.config/fish/functions
if [ -e "$FUNCTIONS_DIR" ] && [ ! -L "$FUNCTIONS_DIR" ]; then
  echo "Removing existing non-symlinked $FUNCTIONS_DIR (functions should live in dotfiles/fish/functions)"
  rm -rf "$FUNCTIONS_DIR"
fi
ln -sfn $PWD/fish/functions $FUNCTIONS_DIR
echo -e "Symlinked fish functions\n"

echo "Setup complete"

#   brew install luarocks
#   brew install lazygit
#   starship
#   zoxide
#   eza
#   cargo install --locked tree-sitter-cli
#   brew install luarocks
#   cargo install --locked zellij
