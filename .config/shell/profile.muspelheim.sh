# Piggyback environment variables used for aliases
export PRIMARY_WORKSPACE=$HOME/WORKSPACE
export METACFG_LOCATION=$PRIMARY_WORKSPACE/bokuno/metadata

# trash-cli alias
alias rm='trash-put'

# Docker run default option
# Mandatory configuration items for all images
export DOCKER_DEFOPTIONS="--rm -it \
    --privileged \
    -e DISPLAY=${DISPLAY} \
    -e TERM=xterm-256color \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.bashrc:/home/${USER}/.bashrc \
    -v $HOME/.config:/home/${USER}/.config \
    -v $HOME/.local:/home/${USER}/.local \
    -v $HOME/.tmux.conf:/home/${USER}/.tmux.conf \
    -v $HOME/.ssh:/home/${USER}/.ssh \
    -v $HOME/.vim:/home/${USER}/.vim \
    -v $HOME/.vimrc:/home/${USER}/.vimrc \
    -v $PRIMARY_WORKSPACE:/home/${USER}/WORKSPACE \
    --add-host excelforejp.com:192.168.23.10 "

