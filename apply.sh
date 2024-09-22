#!/bin/bash
set -e

read -p "Setup [bash/zsh/both]? " -r
case "$REPLY" in
    "bash")
        cat bash/_setup.sh >> ~/.bashrc
        ;;
    "zsh")
        cat zsh/_setup.sh >> ~/.zshrc
        ;;
    "both")
        cat bash/_setup.sh >> ~/.bashrc
        cat zsh/_setup.sh >> ~/.zshrc
        ;;
    *)
        echo Invalid input
        exit 1
esac

cp -r .bashrc.d ~/.bashrc.d

files=(".inputrc" ".vimrc")
for file in ${files[@]}; do
    read -p "Setup $file? [y/N] " -n 1 -r
    echo
    if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
        continue
    fi
    if [ -f ~/$file ]; then
        mv ~/$file ~/$file.old
    fi
    cp $file ~/$file
done

read -p "Configure git? [y/N] " -n 1 -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    if [ -f ~/.gitconfig ]; then
        mv ~/.gitconfig ~/.gitconfig.old
    fi
    cp .gitconfig ~/.gitconfig

    read -p "git email: " -r
    git config --global user.email "$REPLY"
    read -p "git name: " -r
    git config --global user.name "$REPLY"
fi

echo "Done."
