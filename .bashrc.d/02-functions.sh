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
