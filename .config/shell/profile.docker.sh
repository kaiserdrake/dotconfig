# Piggyback environment variables used for aliases
export PRIMARY_WORKSPACE=$HOME/WORKSPACE
export METACFG_LOCATION=$PRIMARY_WORKSPACE/bokuno/metadata

# trash-cli alias
alias rm='trash-put'

# When using Docker Desktop, containers within WSL2 are not able to access
# to the host docker IP address as described here:https://docs.docker.com/network/
[ -z $DISPLAY ] && DISPLAY=host.docker.internal:0.0 && export DISPLAY

