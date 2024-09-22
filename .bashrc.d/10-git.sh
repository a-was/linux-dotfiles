alias gs="git status"
alias gb="git branch --all -vv"
alias gcb="git checkout -b"
alias gf="git fetch --all --prune"

alias gmnff="git merge --no-ff -e"
alias gcl="git clone --recurse-submodules"
# alias gsps="git stash && git pull && git stash pop"

unalias gsps 2>/dev/null
function gsps {
	echo "Git stash"
	git stash -u
	echo
	echo "Git pull"
	git pull
	echo
	echo "Git stash pop"
	git stash pop
}

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
function code-pull-branches {
	current=$(git name-rev --name-only HEAD)
	for branch in $(git for-each-ref --format="%(refname)" refs/heads/ | awk -F "refs/heads/" '{print $2}'); do
		git checkout $branch
		git pull
		echo
	done
	git checkout $current
}
