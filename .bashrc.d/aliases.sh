# system
alias update="sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove"
alias u1="sudo apt update"
alias u2="sudo apt list --upgradable"
alias u3="sudo apt upgrade -V"
alias u4="sudo apt autoremove"

alias vi="vim"
alias p="python3"

# ls
alias ls="\ls -hFv --color=auto"
alias ll="ls -lA"   # all info
alias la="ll"       # all info
alias l="ls -lX"    # sort by extension
alias lk="ll -Sr"   # sort by size
alias lt="ll -tr"   # sort by time
alias l.="ll -d .*" # only .dotfiles

# files
alias rm="rm -dI"
alias rr="rm -rf"
alias cp="cp -ir"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias mk="mkdir"

# other
alias q="exit"
alias c="clear"
alias cs="clear;ll"
alias calc="bc -l"
alias du="du -h"
alias DU="du -had1 | sort -h"
alias df="df -h"
alias free="free -m"

# path
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias back="echo $OLDPWD; cd $OLDPWD"
alias fhere="find . -name "
alias froot="find / -name "
