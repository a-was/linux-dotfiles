if ! has_cmd docker; then
    return
fi

# removes all stopped docker containers
function containers-cleanup() {
	docker ps -a \
		--format "{{.Names}}" \
		--filter "status=exited" \
		--filter "status=dead" \
		--filter "status=created" \
	| xargs -I{} --max-procs 5 --no-run-if-empty docker rm {}
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
