# git
alias g="git"
alias gs="git status"

alias gb="git branch"
alias gbd="git branch --delete --force"
alias gcb="git checkout -b"

alias gc="git commit"
alias gcm="git commit . -m"

alias gf="git fetch"
alias gfa="git fetch --all --prune"

alias gmnff="git merge --no-ff -e"
# alias gsps="git stash && git pull && git stash pop"
alias gcl="git clone --recurse-submodules"

alias gsp="git stash pop"
alias gsd="git stash drop"

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

# renames old branch to new, including in origin remote
function code-rename-branch {
	if [[ -z "$1" || -z "$2" ]]; then
		echo "Usage: $0 old_branch new_branch"
		return 1
	fi

	# rename branch locally
	git branch --move "$1" "$2"
	# rename branch in origin remote
	if git push origin :"$1"; then
		git push --set-upstream origin "$2"
	fi
}

# deletes branch, including in origin remote
function code-delete-branch {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 branch_to_delete"
		return 1
	fi

	# delete branch locally
	git branch --delete "$1"
	# delete branch in origin remote
	git push origin :"$1"
}

function code-create-tag {
	if [[ -z "$1" ]]; then
		echo "Usage: $0 tag_to_create"
		return 1
	fi

	# create tag locally
	git tag $1
	# create tag in origin remote
	git push origin $1
}
