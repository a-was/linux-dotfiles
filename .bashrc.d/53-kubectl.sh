if ! has_cmd kubectl; then
    return
fi

function kubecontext-from-file() {
    if [[ -z $1 || -z $2 ]]; then
        echo "Usage: $0 [context name] [kubeconfig file path]"
        return 1
    fi

    local NAME="$1"
    local FILE="$2"

    local TEMP_FILE="$HOME/.kube/tmp"
    KUBECONFIG="$KUBECONFIG:$TEMP_FILE"

    cp "$FILE" "$TEMP_FILE"
    sed -i -E "s|name: \w+|name: $NAME|g" "$TEMP_FILE"
    sed -i -E "s|cluster: \w+|cluster: $NAME|g" "$TEMP_FILE"
    sed -i -E "s|user: \w+|user: $NAME|g" "$TEMP_FILE"

    kubectl config view --raw > "$HOME/.kube/config"

    rm "$TEMP_FILE"
}

function kubecontext-from-ssh() {
    if [[ -z $1 || -z $2 ]]; then
        echo "Usage: $0 [context name] [ssh target]"
        return 1
    fi

    local NAME="$1"
    local TARGET="$2"

    local IP="ip route get 1.1.1.1 | head -1 | cut -d' ' -f7"
    local CONFIG="kubectl config view --minify --flatten"
    local HOST="cat /etc/hostname"

    local SED1='sed s/127.0.0.1/$('${IP}')/'
    local SED2='sed s/default/$('${HOST}')/'

    local CMD=${CONFIG}' | '${SED1}' | '${SED2}

    # execute
    local TEMP_FILE="$(mktemp)"
    ssh "$TARGET" "$CMD" > "$TEMP_FILE"
    chmod 600 "$TEMP_FILE"

    kubecontext-from-file "$NAME" "$TEMP_FILE"
    rm "$TEMP_FILE"
}
