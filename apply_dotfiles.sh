#!/bin/bash
cat .bashrc_addons >> ~/.bashrc
cat .bash_aliases >> ~/.bash_aliases
cp .bash_functions ~/.bash_functions
cp .bash_prompt ~/.bash_prompt

cat .inputrc >> ~/.inputrc
cat .vimrc >> ~/.vimrc

cp ufetch.sh ~/.ufetch.sh

bash
