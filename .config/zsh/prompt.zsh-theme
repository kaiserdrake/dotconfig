# vim: filetype=sh

# Prompt symbol
ZSHTHEME_PROMPT_SYMBOL="$"

# Colors
ZSHTHEME_COLORS_HOST_ME=green
ZSHTHEME_COLORS_HOST_DOCKER=red
ZSHTHEME_COLORS_VIMTERM=red
ZSHTHEME_COLORS_CURRENT_DIR=blue
ZSHTHEME_COLORS_RETURN_STATUS_TRUE=yellow
ZSHTHEME_COLORS_RETURN_STATUS_FALSE=red
ZSHTHEME_COLORS_GIT_STATUS_DEFAULT=green
ZSHTHEME_COLORS_GIT_STATUS_STAGED=red
ZSHTHEME_COLORS_GIT_STATUS_UNSTAGED=yellow
ZSHTHEME_COLORS_GIT_PROMPT_SHA=green
ZSHTHEME_COLORS_BG_JOBS=yellow

# Left Prompt
PROMPT='$(zshtheme_host)$(zshtheme_current_dir)$(zshtheme_bg_jobs)$(zshtheme_return_status)'

# Right Prompt
RPROMPT='$(zshtheme_vim_term) $(zshtheme_git_status)'

# Host
zshtheme_host() {
    me="%F{$ZSHTHEME_COLORS_HOST_ME}%n@%m%f"
    if [[ -n $me ]]; then
        if within_docker; then
            echo "$me%{$reset_color%}#%F{$ZSHTHEME_COLORS_HOST_DOCKER}$META_IMAGEREF%f%{$reset_color%}:"
        else
            echo "$me%{$reset_color%}:"
        fi
    fi
}

# Current directory
zshtheme_current_dir() {
    echo -n "%F{$ZSHTHEME_COLORS_CURRENT_DIR}%-23<...<%~%<<"
}

# Prompt symbol
zshtheme_return_status() {
    echo -n "\n%(?.%F{$ZSHTHEME_COLORS_RETURN_STATUS_TRUE}.%F{$ZSHTHEME_COLORS_RETURN_STATUS_FALSE})$ZSHTHEME_PROMPT_SYMBOL%f "
}

# Git status
zshtheme_git_status() {
    local message=""
    local message_color="%F{$ZSHTHEME_COLORS_GIT_STATUS_DEFAULT}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
        message_color="%F{$ZSHTHEME_COLORS_GIT_STATUS_STAGED}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{$ZSHTHEME_COLORS_GIT_STATUS_UNSTAGED}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+="${message_color}${branch}%f"
    fi

    echo -n "${message}"
}

zshtheme_vim_term(){
    local message=""
    local message_color="%F{$ZSHTHEME_COLORS_VIMTERM}"
    if [ ! -z "$VIM_TERMINAL" ] || [ ! -z "$NVIM_LISTEN_ADDRESS" ]; then
        message+="${message_color}VIMTERM%f"
    fi
    echo -n "${message}"
}

# Git prompt SHA
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{$ZSHTHEME_COLORS_GIT_PROMPT_SHA}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

# Background Jobs
zshtheme_bg_jobs() {
    bg_status="%{$fg[$ZSHTHEME_COLORS_BG_JOBS]%}%(1j.↓%j .)"
    echo -n $bg_status
}
