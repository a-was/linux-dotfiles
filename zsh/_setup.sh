
# >>> linux-dotfiles >>>
if [[ -d "$HOME/.bashrc.d" ]]; then
    for file in $HOME/.bashrc.d/*; do
        . $file
    done
fi

export EDITOR="vim"
export VISUAL="vim"
export DOCKER_BUILDKIT=1

export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

if has_cmd bat; then
    function zle_help {
        # If --help flag found, pipe output through bat
        if [[ "$BUFFER" =~ '^(-?\w\s?)+ --help$' ]]; then
            BUFFER="$BUFFER | bat -p -l help"
        fi

        # press enter
        zle accept-line
    }
    zle -N zle_help
    bindkey '^J' zle_help
    bindkey '^M' zle_help
fi
# <<< linux-dotfiles <<<
