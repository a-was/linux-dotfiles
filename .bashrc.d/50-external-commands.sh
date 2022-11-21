function has_cmd() {
	# command -v "$1" >/dev/null
	hash "$1" 2>/dev/null
}

if has_cmd exa; then
	alias l="exa -lgF --octal-permissions"
	alias ll="exa -lagF --octal-permissions"
fi

if has_cmd bat; then
	export BAT_THEME="Visual Studio Dark+"
	# export BAT_THEME="gruvbox-dark"

	alias cat="bat -p"

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
