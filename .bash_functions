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
alias mktar='maketar'

# Create a ZIP archive of a file or folder
function makezip {
	zip -r "${1%%/}.zip" "$1"
}
alias mkzip='makezip'

# deletes local branches that was deleted on remote
function code-cleanup {
	git fetch -p
	branches=$(git branch -vv | grep ': gone]' | awk '{print $1}')

	if [ -z $branches ]; then
		echo "Nothing to do"
		return
	fi

	for branch in $branches; do
		git branch --delete --force $branch
	done
}

# pulls all local branches
function code-pull {
	current=$(git name-rev --name-only HEAD)
	for branch in $(git for-each-ref --format='%(refname)' refs/heads/ | awk -F 'refs/heads/' '{print $2}'); do
		git checkout $branch
		git pull
		echo
	done
	git checkout $current
}

# pulls all branches
function code-pull-all {
	git branch -r | grep -v '\->' | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g" | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
}
