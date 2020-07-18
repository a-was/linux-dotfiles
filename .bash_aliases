# if You want to read external files
read_prompt_file=true
read_functions_file=true

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

# Path
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


if $read_prompt_file && [ -f $HOME/.bash_prompt ] ; then
    . $HOME/.bash_prompt
fi

if $read_functions_file && [ -f $HOME/.bash_functions ] ; then
    . $HOME/.bash_functions
fi

# setting vim as default editor
export EDITOR='vim'
export VISUAL='vim'

# DEFAULT="\[\033[00m\]"
# WHITE="\[\033[38;5;15m\]"
# GREEN="\[\033[38;5;82m\]"
# CYAN="\[\033[38;5;51m\]"
# PURPLE="\[\033[38;5;165m\]"

# user@host:~/path $ 
# export PS1="${GREEN}\u${WHITE}@${CYAN}\h${WHITE}:${PURPLE}\w${WHITE} $ ${DEFAULT}"
# 8 bit
# export PS1="\e[92m\u\e[97m@\e[96m\h\e[97m:\e[95m\w\e[97m $ \e[39m"
