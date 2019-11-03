#!/bin/bash
cat .bashrc_addons >> ~/.bashrc
cat .bash_aliases >> ~/.bash_aliases
cat .bash_functions >> ~/.bash_functions
cat .inputrc >> ~/.inputrc
cat .vimrc >> ~/.vimrc

cp ufetch.sh ~/.ufetch.sh

bash
