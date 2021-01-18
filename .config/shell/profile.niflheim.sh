# Piggyback environment variables used for aliases
export PRIMARY_WORKSPACE=$HOME/WORKSPACE
export METACFG_LOCATION=$PRIMARY_WORKSPACE/bokuno/metadata

# trash-cli alias
alias rm='trash-put'

# Docker run default option - mandatory configuration items for all images.
# This variable is placed in host specific profile due to the dependency
# on PRIMARY_WORKSPACE environment variable.
export DOCKER_DEFOPTIONS="--rm -it \
    --privileged \
    -e DISPLAY=${DISPLAY} \
    -e TERM=xterm-256color \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.bash_history:/home/${USER}/.bash_history \
    -v $HOME/.bashrc:/home/${USER}/.bashrc \
    -v $HOME/.config:/home/${USER}/.config \
    -v $HOME/.local:/home/${USER}/.local \
    -v $HOME/.tmux.conf:/home/${USER}/.tmux.conf \
    -v $HOME/.ssh:/home/${USER}/.ssh \
    -v $PRIMARY_WORKSPACE:/home/${USER}/WORKSPACE "

# Google Cloud SDK bash completion
if [ -f '$HOME/.config/gloud/google-cloud-sdk/path.bash.inc' ]; then
    . '$HOME/.config/gloud/google-cloud-sdk/path.bash.inc';
fi
# The next line enables shell command completion for gcloud.
if [ -f '$HOME/.config/gloud/google-cloud-sdk/completion.bash.inc' ]; then
    . '$HOME/.config/gloud/google-cloud-sdk/completion.bash.inc';
fi
