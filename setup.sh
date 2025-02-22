#!/bin/bash
export XDG_CONFIG_HOME=$HOME/.config
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_CONFIG_HOME/nixpkgs

ln -sf $PWD/.config/nvim $XDG_CONFIG_HOME/nvim
ln -sf $PWD/.config/neofetch $XDG_CONFIG_HOME/neofetch
ln -sf $PWD/.bashrc $HOME/.bashrc
ln -sf $PWD/.config/starship.toml $HOME/starship.toml
ln -sf $PWD/config.nix $XDG_CONFIG_HOME/nixpkgs/config.nix

nix-env -iA nixpkgs.myPackages
