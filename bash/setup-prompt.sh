#!/bin/bash
set -ex

git clone --depth=1 https://github.com/romkatv/gitstatus.git ~/gitstatus
echo 'source ~/gitstatus/gitstatus.prompt.sh' >> ~/.bashrc

echo >> ~/.bashrc

cp prompt.sh ~/.bashrc.d/00-prompt.sh
echo 'source ~/.bashrc.d/00-prompt.sh' >> ~/.bashrc
echo 'export PROMPT_COMMAND="__myprompt"' >> ~/.bashrc
