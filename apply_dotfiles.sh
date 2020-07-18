#!/bin/bash

cat .bashrc_addons >> ~/.bashrc

files=(".bash_aliases" ".bash_functions" ".bash_prompt" ".inputrc" ".vimrc")
for file in ${files[*]} ; do
    if [ -f $HOME/$file ] ; then
        mv $HOME/$file $HOME/$file.old
    fi
    cp $file $HOME/$file
done

cp ufetch.sh ~/.ufetch.sh

bash
