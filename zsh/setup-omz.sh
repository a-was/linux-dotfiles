#!/bin/bash
set -e

echo setup: Installing oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# sh -c "$(curl -fsSL https://install.ohmyz.sh/)"
echo


echo setup: Disabling defaults
sleep 0.5

sed -i '/^ZSH_THEME=".*"/ s/^/#!# /' "~/.zshrc"
sed -i '/^plugins=(/ s/^/#!# /' "~/.zshrc"
sed -i '/^source \$ZSH\/oh-my-zsh.sh/ s/^/#!# /' "~/.zshrc"


echo setup: Setting custom variables
sleep 0.5

cat << EOF >> "~/.zshrc"


# MY CONFIGURATION

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="%F{yellow}...%f"
HIST_STAMPS="yyyy-mm-dd"

EOF


echo setup: Installing plugins
sleep 0.5

echo setup: Installing zsh-autosuggestions
sleep 0.5
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo

echo setup: Installing conda-zsh-completion
sleep 0.5
git clone https://github.com/conda-incubator/conda-zsh-completion ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/conda-zsh-completion
echo

echo setup: Enabling plugins
sleep 0.5

cat << EOF >> "~/.zshrc"
plugins=(
    git
    command-not-found
    rsync
    copyfile
    copypath

    docker
    docker-compose
    kubectl
    helm

    pip
    asdf
    httpie

    zsh-autosuggestions
    conda-zsh-completion
)

source \$ZSH/oh-my-zsh.sh

EOF


read -p "Install p10k? [y/N] " -n 1 -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    echo setup: Installing powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo

    echo setup: Setting theme to powerlevel10k
    sed -i '/^ZSH_THEME=".*"/ s/^/# /' "~/.zshrc"
    sed -i '/^# ZSH_THEME=".*"/a ZSH_THEME="powerlevel10k/powerlevel10k"' "~/.zshrc"
fi

echo setup: Done.
echo setup: Running zsh

sleep 1
exec zsh
