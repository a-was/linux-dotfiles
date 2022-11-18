if ! has_cmd kubectl; then
    return
fi

function kubecontext-from-file() {
    if [[ -z $1 || -z $2 ]]; then
        echo "Usage: $0 [context name] [kubeconfig file path]"
        return 1
    fi

    NAME="$1"
    FILE="$2"

    TEMP_FILE="$HOME/.kube/tmp"
    KUBECONFIG="$KUBECONFIG:$TEMP_FILE"

    cp "$FILE" "$TEMP_FILE"
    sed -i -E "s|name: \w+|name: $NAME|g" "$TEMP_FILE"
    sed -i -E "s|cluster: \w+|cluster: $NAME|g" "$TEMP_FILE"
    sed -i -E "s|user: \w+|user: $NAME|g" "$TEMP_FILE"

    kubectl config view --raw > "$HOME/.kube/config"

    rm "$TEMP_FILE"
}
