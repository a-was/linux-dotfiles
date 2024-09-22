#!/bin/bash
set -e

git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/.local/gitstatus

cp _prompt.sh ~/.bashrc.d/00-prompt.sh

cat << EOF >> ~/.bashrc

>>> linux-dotfiles prompt >>>
source ~/.local/gitstatus/gitstatus.prompt.sh
source ~/.bashrc.d/00-prompt.sh
export PROMPT_COMMAND="__myprompt"
<<< linux-dotfiles prompt <<<

EOF
