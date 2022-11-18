#!/bin/bash
set -ex

echo >> ~/.bashrc
cat .bashrc_addons >> ~/.bashrc

cp -r .bashrc.d ~/.bashrc.d

files=(".inputrc" ".vimrc")
for file in $files; do
    if [ -f ~/$file ]; then
        mv ~/$file ~/$file.old
    fi
    cp $file ~/$file
done
