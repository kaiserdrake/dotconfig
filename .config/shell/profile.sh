# -----------------------------------------------------------------------------
# Global exports
# -----------------------------------------------------------------------------
# As much as possible place exports here since usual guides and tips uses appends of exports
# at the end of this file. The intention is previous exports made by this file should be
# overwritten in those cases.
# gtags
export GTAGSLABEL=ctags # default gtags tag provider

# fzf/ripgrep
export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

# -----------------------------------------------------------------------------
# Common settings
# -----------------------------------------------------------------------------
# Set editor to vim (bye emacs)
export VISUAL=vim
export EDITOR="$VISUAL"

export PRIMARY_WORKSPACE=$HOME/WORKSPACE
export METACFG_LOCATION=$PRIMARY_WORKSPACE

# export TERM=xterm-256color
alias ls='ls --color=always'

# Alias to organize dot configs as bare git repository
alias dotcfg='/usr/bin/git --git-dir=$HOME/.dotconfig/ --work-tree=$HOME'

# Alias ssh to use xterm
alias ssh='TERM=xterm-256color ssh'

# preload shell functions
if [ -f ~/.config/shell/functions_preload.sh ]; then
    . ~/.config/shell/functions_preload.sh
fi

# Apply host specific overrides from this section.
# This is useful when the configuration is used in multiple machines with
# subtle changes  (e.g. PRIMARY_WORKSPACE location difference).
HOSTN=`echo $HOSTNAME | awk '{print tolower($0)}'`
if [ -f ~/.config/shell/profile.$HOSTN.sh ]; then
    . ~/.config/shell/profile.$HOSTN.sh
fi
if within_docker; then
    . ~/.config/shell/profile.docker.sh
fi

# -----------------------------------------------------------------------------
# X11 forwarding
# -----------------------------------------------------------------------------
# Set X11 server windows application keyboard layout
# When unders WSL and using X410 x11 server, default keyboard layout is US
KERNEL_RELEASE=$(cat /proc/sys/kernel/osrelease | sed -n 's/.*\( *Microsoft *\).*/\L\1/ip')
if [ "$KERNEL_RELEASE" == "microsoft" ]; then
    # WSL2 runs virtualization where linux kernel runs on different network
    # thus use of localhost is different
    [ -z $DISPLAY ] && export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

    # Perform after setting DISPLAY value
    # set keyboard layout
    # if [ -f /usr/bin/setxkbmap ]; then
    #     /usr/bin/setxkbmap jp
    # fi
else
    # Set display for X11 forwarding
    [ -z $DISPLAY ] && DISPLAY=localhost:0.0 && export DISPLAY
fi

# -----------------------------------------------------------------------------
# tmux
# -----------------------------------------------------------------------------
# do not include remote shell (screen) and ensure that recursive tmux does not occur
if ! within_docker; then
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ eterm ]] && \
        [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && \
        [[ ! -n "$SSH_CLIENT" ]] && [[ ! -n "$SSH_TTY" ]] ; then
        exec tmux attach
    fi
    if [[ $TMUX ]]; then
        tmux rename-window `generate-name`
    fi
fi
