
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

# source <(kubectl completion bash)
# alias k="kubectl"
# complete -F __start_kubectl k
# source <(helm completion bash)

bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"
# <<< linux-dotfiles <<<
