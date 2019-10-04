# system
alias ins='sudo apt-get install'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias root='sudo bash'

# ls
alias ls='ls -hAFv --color=auto'
alias lk='ls -lSr'  # size
alias lt='ls -ltr'  # time
alias l.='ls -d .*'  # only .dotfiles
alias ll='ls -l'  # all info
alias l='ll -X'  # sort by extension

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
alias cs='clear;l'
alias calc='bc -l'
alias du='du -h'
alias DU='du -had1 | sort -h'
alias py='python3'
alias p='py'

# PATH
alias ..='cd ..'
alias ...='cd ../..'
alias back='echo $OLDPWD;cd $OLDPWD'
alias fhere="find . -name "

# user@host [~/path] $ 
# export PS1='\[\e]0;\u@\h: \w\a\]\[\033[38;5;82m\]\u\[\033[38;5;15m\]@\[\033[38;5;51m\]\h \[\033[38;5;15m\][\[\033[38;5;165m\]\w\[\033[38;5;15m\]] $ \[\033[00m\]'

# user@host:~/path $ 
export PS1='\[\e]0;\u@\h: \w\a\]\[\033[38;5;82m\]\u\[\033[38;5;15m\]@\[\033[38;5;51m\]\h\[\033[38;5;15m\]:\[\033[38;5;165m\]\w\[\033[38;5;15m\] $ \[\033[00m\]'

set -o vi
export EDITOR='vi'
export VISUAL='vi'

