function mkcd {
	if [ ! -n "$1" ]; then
		echo "Enter a directory name"
	elif [ -d $1 ]; then
		echo "'$1' already exist "
		cd $1
	else
		mkdir $1;
		cd $1
	fi
}

# Creates an archive (*.tar.gz) from given directory
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

note () {
	# if file doesn't exist, create it
	if [[ ! -f $HOME/.notes ]]; then
		touch "$HOME/.notes"
	fi
	if ! (($#)); then
		# no arguments, print file
		nl -b a "$HOME/.notes"
	elif [[ "$1" == "-c" ]]; then
		# clear file
		> "$HOME/.notes"
	elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
		# help
		printf "Simple notebook. Use -c to clear file or -r to remove line\n"
	elif [[ "$1" == "-c" ]]; then
		nl -b a "$HOME/.notes"
		eval printf %.0s- '{1..'"$COLUMNS:-$(tput cols)}"\}; echo
		read -p "Type a number to remove: " number
		sed -i ${number}d $HOME/.notes "$HOME/.notes"
	else
		# add all arguments to file
		echo "%s\n" "$*" >> "$HOME/.notes"
	fi
}

todo() {
	if [[ ! -f $HOME/.todo ]]; then
		touch "$HOME/.todo"
	fi
	if ! (($#)); then
		cat "$HOME/.todo"
	elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
		echo "Simple todo list. Use -l to list lines, -c to clear file or -r to remove line\n"
	elif [[ "$1" == "-l" ]]; then
		nl -b a "$HOME/.todo"
	elif [[ "$1" == "-c" ]]; then
		> $HOME/.todo
	elif [[ "$1" == "-r" ]]; then
		nl -b a "$HOME/.todo"
		eval printf %.0s- '{1..'"${COLUMNS:-$(tput cols)}"\}; echo
		read -p "Type a number to remove: " number
		sed -i ${number}d $HOME/.todo "$HOME/.todo"
	else
		printf "%s\n" "$*" >> "$HOME/.todo"
	fi
}
