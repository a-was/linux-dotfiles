# git
alias gs="git status"
alias gc="git commit"
alias gcm="git commit . -m"
alias gb="git branch"
alias gcb="git checkout -b"
alias gmnff="git merge --no-ff -e"
alias gsps="git stash && git pull && git stash pop"

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
