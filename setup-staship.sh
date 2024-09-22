#!/bin/bash
set -e

read -p "Install [g]lobaly or [l]ocally? " -n 1 -r
echo
if [[ "$REPLY" == "g" ]]; then
    curl -sS https://starship.rs/install.sh | sh
elif [[ "$REPLY" == "l" ]]; then
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin
else
    echo Invalid input
    exit 1
fi


read -p "Configure [b]ash or [z]sh? " -n 1 -r
echo
if [[ "$REPLY" == "b" ]]; then
    echo >> ~/.bashrc
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
    echo >> ~/.bashrc
elif [[ "$REPLY" == "z" ]]; then
    echo >> ~/.zshrc
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo >> ~/.zshrc
else
    echo Invalid input
    exit 2
fi


read -p "Configure conda? [y/N] " -n 1 -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    conda config --set changeps1 False
fi


mkdir -p ~/.config
cp starship.toml ~/.config/starship.toml
