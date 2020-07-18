# system
alias ins='sudo apt-get install'
alias update='sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y autoremove'
alias root='sudo bash'

alias vi='vim'
alias py='python3'
alias p='python3'
alias curljson='curl -X POST -H "Content-Type: application/json"'

# ls
alias ls='\ls -hFv --color=auto'
alias ll='ls -lA'  # all info
alias la='ll' # all info
alias l='ls -lX'  # sort by extension
alias lk='ll -Sr'  # sort by size
alias lt='ll -tr'  # sort by time
alias l.='ll -d .*'  # only .dotfiles

# files
alias rm='rm -dI'
alias rr='rm -rf'
alias cp='cp -ir'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias mk='mkdir'

# other
alias q='exit'
alias c='clear'
alias cs='clear;ll'
alias calc='bc -l'
alias du='du -h'
alias DU='du -had1 | sort -h'
alias df='df -h'
alias free='free -m'

# path
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='echo $OLDPWD;cd $OLDPWD'
alias fhere='find . -name '
alias froot='find / -name '

# docker
function dk_ex () {
    docker exec -it $1 ${2:-bash}
}
alias dk='docker'
alias dkex='dk_ex'
alias dki='docker image ls'
alias dkps='docker ps -a'
alias dks='docker start'
alias dkst='docker stop'
