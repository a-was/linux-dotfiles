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

# git
alias gs="git status"
alias gc="git commit"
alias gcm="git commit . -m"
alias gb="git branch"
alias gcb="git checkout -b"
alias gmnff="git merge --no-ff -e"
alias gsps="git stash && git pull && git stash pop"

# functions

function mkcd {
	if [ ! -n "$1" ]; then
		echo "Enter a directory name"
	elif [ -d $1 ]; then
		echo "'$1' already exist "
		cd $1
	else
		mkdir $1
		cd $1
	fi
}

# Creates an archive (*.tar.gz) from given directory
function maketar {
	tar cvzf "${1%%/}.tar.gz" "${1%%/}/"
}
alias mktar="maketar"

# Create a ZIP archive of a file or folder
function makezip {
	zip -r "${1%%/}.zip" "$1"
}
alias mkzip="makezip"

function localip() {
	echo $(ip route get 1.1.1.1 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
}
export LOCAL_IP=$(localip)

# git

# deletes local branches that was deleted on remote
function code-cleanup {
	git fetch -p
	branches=$(git branch -vv | grep ": gone]" | awk '{print $1}')

	if [ -z $branches ]; then
		echo "Nothing to do"
		return
	fi

	echo $branches | xargs -I{} --no-run-if-empty git branch --delete --force {}
}

# pulls all local branches
function code-pull {
	current=$(git name-rev --name-only HEAD)
	for branch in $(git for-each-ref --format="%(refname)" refs/heads/ | awk -F "refs/heads/" '{print $2}'); do
		git checkout $branch
		git pull
		echo
	done
	git checkout $current
}

# pulls all branches
function code-pull-all {
	git branch -r | grep -v "\->" | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
}

# docker

# removes all stopped docker containers
function containers-cleanup() {
	docker ps -a --format "{{.Names}}" --filter "status=exited" --filter "status=dead" | xargs -I{} --max-procs 5 --no-run-if-empty docker rm {}
}

# stops all docker containers
function containers-stop() {
	docker ps --format "{{.Names}}" | xargs -I{} --max-procs 5 --no-run-if-empty docker stop {}
}

# stops and removes all docker containers
function containers-rm() {
	containers-stop
	docker ps -a --format "{{.Names}}" | xargs -I{} --max-procs 5 --no-run-if-empty docker rm {}
}

# bat
if command -v bat &> /dev/null; then
	alias cat="bat"

	function tf() {
		tail -f $1 | bat --paging=never ${@:2}
	}

	function tfl() {
		tail -f $1 | bat --paging=never -l log
	}

	export MANPAGER="sh -c 'col -bx | bat -l man -p'"
	export MANROFFOPT="-c"

	help() {
		"$@" --help 2>&1 | bat --plain --language=help
	}
fi

# exa
if command -v exa &> /dev/null; then
	alias l="exa -lgF --octal-permissions"
	alias ll="exa -lagF --octal-permissions"
fi
