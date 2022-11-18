if ! has_cmd go; then
    return
fi

function gomod() {
    find . -name "go.mod" -printf "%h\n" \
    | sort -u \
    | xargs -I{} bash -c "echo {} && cd {} && go mod tidy" \

}

if has_cmd CompileDaemon; then
	function gocd() {
		CompileDaemon \
			-build="true" \
			-command="${1:-go run .}" \
			-command-stop="true" \
			-directory="${2:-.}" \
			-include="*.sh" \
			-color="true" \
			-log-prefix="false" \

	}
fi
