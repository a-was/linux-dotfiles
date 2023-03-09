function __myprompt_right {
    local OUT=""

    if [[ -n "$VIRTUAL_ENV" ]]; then
        OUT+="$(basename "$VIRTUAL_ENV")"
    fi

    if [[ -n "$OUT" ]]; then
        printf "%*s" $COLUMNS "$OUT"
    fi
}

function __myprompt {
    local exitcode="$?"

    local show_exitcode="false"

    local GREEN='\[\033[38;5;10m\]'
    local YELLOW='\[\033[38;5;11m\]'
    local BLUE='\[\033[36m\]'
    local RED='\[\033[38;5;9m\]'
    local CYAN='\[\033[38;5;14m\]'
    local RESET='\[$(tput sgr0)\]'
    # local RESET='\[\033[0m\]\n'

    PS1='\[$(tput sc; __myprompt_right; tput rc)\]'
    # PS1=""

    # if [[ -n "$VIRTUAL_ENV_PROMPT" ]]; then
    #     PS1+="$VIRTUAL_ENV_PROMPT"
    # fi

    PS1+="${CYAN}\w${RESET}"

    if command -v gitstatus_prompt_update >/dev/null; then
        gitstatus_prompt_update
    else
        GITSTATUS_PROMPT=""
        local git_branch=$(git --no-optional-locks rev-parse --abbrev-ref HEAD 2> /dev/null)
        if [[ -n "$git_branch" ]]; then
            GITSTATUS_PROMPT="${YELLOW}‹${git_branch}›${RESET}"
            # GITSTATUS_PROMPT="${YELLOW}(${git_branch})${RESET}"
        fi
    fi
    if [[ -n "$GITSTATUS_PROMPT" ]]; then
        GITSTATUS_PROMPT=" $GITSTATUS_PROMPT"
    fi

    PS1+="$GITSTATUS_PROMPT "

    if [[ $exitcode == 0 ]]; then
        PS1+="$GREEN"
    else
        PS1+="$RED"
        if [[ "$show_exitcode" == "true" ]]; then
            PS1+="[${exitcode}] "
        fi
    fi
    PS1+="❯"
    # PS1+="➜"
    # PS1+="\$"

    PS1+="$RESET "
}
# export PROMPT_COMMAND="__myprompt"
