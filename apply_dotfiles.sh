#!/bin/bash

set -ex

echo >> ~/.bashrc
cat .bashrc_addons >> ~/.bashrc

files=(".bash_aliases" ".inputrc" ".vimrc")
for file in $files; do
    if [ -f $HOME/$file ]; then
        mv $HOME/$file $HOME/$file.old
    fi
    cp $file $HOME/$file
done
