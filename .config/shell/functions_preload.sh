# Be carefull not to overload bash with custom functions since these are
# loaded upon initialization. When on-demand or lazy loading can already
# be supported by bash, then this restriction can be lifted.

# Check function if execution context is within a docker container
function within_docker() {
    awk -F/ '$2 == "docker"' /proc/self/cgroup | read
}

# Command list generator using 'history' as source.
# It truncates the first 7 characters in each line.
# Thus adding timestamp via HISTTIMEFORMAT in the history entry requires
# change of the offset where the actual command starts.
# This is not done automatically in the function.
function get-history-lines(){
    history | sed  's .\{7\}  ' | sed -e '/^do-command/d;/^doco /d'
}

# Command list generator using "commands.md" as source.
# This parses multiline commands and joins them into single entry.
# It is intended to work in markdown files where it tgnores lines starting with
# either # or ```.
function get-stored-command-lines(){
    if [ -f "$1" ]; then
        cat "$1" | sed ':loop /^[^#].*[^\\]\\$/N; s/\\\n//; t loop' | sed -e '/^#/d;/^```/d;/^$/d' | tr -s " "
    fi
}

# Output the ROM and RAM Data Size of a particular object file.
function get-code-size(){
    output=$(size -t $1 | grep "TOTALS")
    echo "--------------------------------------------------------------------------------"
    echo "ROM Code + Data : `echo ${output} | awk '{print $1}'` bytes"
    echo "RAM Data : `echo ${output} | awk '{print $2+$3}'` bytes"
}

# Command list aggregator.
# Uses fuzzy search to allow searching of commamnds list.
function do-command(){
    unset MY_FIND_COMMAND
    COMFILE="$METACFG_LOCATION/commands.md"
    if [ -z "$1" ]; then
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf`
    else
        MY_FIND_COMMAND=`(get-history-lines && get-stored-command-lines $COMFILE) | sort -u | fzf -q "$1" -1 -0`
    fi
    ${DRYRUN} eval $MY_FIND_COMMAND
}

# Alias to shorten call to do-command
# "doco" shortened "do"-"co"mmand and a wordplay for the Japanese "doko"
alias doco='do-command'

# Function [wrapper] to generate random name ala docker
function generate-name(){
    if [ -x /usr/bin/python3 ]; then
        echo `/usr/bin/python3 ~/.config/python3/names.generate.py`
    fi
}

# docker run
function docker-run(){
    unset DOCKOPTS IMAGENAME COMMANDS DOCKHOST ABODE
    # Identify image name through selection from the list of images returned by
    # 'docker image ls' command.
    if [ -z "$1" ]; then
        IMAGENAME=`docker image list | awk '{if(NR>1)print}'| fzf | awk '{printf "%s:%s\n",$1,$2}'`
    else
        IMAGENAME=`docker image list | awk '{if(NR>1)print}'| fzf -q $1 -1 -0 | awk '{printf "%s:%s\n",$1,$2}'`
    fi

    # Remote registry images results to empty IMAGENAME, user probably pressed
    # <Esc> during the selection. This means a new image from remote registry.
    # In such case, use the value initially provided by the user.
    if [ -z "$IMAGENAME" ]; then
        # revert value to original argument
        IMAGENAME=$1
    fi

    # Fetch run command configuration through the docker.abode.md file.
    COMFILE="$METACFG_LOCATION/docker.abode.md"
    if [ -f "$COMFILE" ]; then
        if [ -z "$IMAGENAME" ]; then
            ABODE=`get-stored-command-lines $COMFILE | fzf --prompt=Pattern: --header "HOSTNAME | IMAGE | OPTIONS | COMMAND" -1 -0`
        else
            ABODE=`get-stored-command-lines $COMFILE | grep $IMAGENAME | fzf --prompt=Pattern: --header "HOSTNAME | IMAGE | OPTIONS | COMMAND" -1 -0`
        fi
    fi

    # Found a corresponding configuration, tokenize it and set to approriate variables.
    if [ ! -z "$ABODE" ]; then
        ABODE=$(echo $ABODE | tr -s " ")
        OLDIFS=$IFS
        IFS='|'
        tokens=($ABODE)
        IFS=$OLDIFS
        DOCKHOST=$(echo ${tokens[0]} | tr -s " ")
        IMAGENAME=$(echo ${tokens[1]} | tr -s " ")
        DOCKOPTS=${tokens[2]}
        COMMANDS=${tokens[3]}
    fi

    # Append run configuration from docker.abode and default.
    DOCKOPTS=$(echo "$DOCKOPTS $DOCKER_DEFOPTIONS" | tr -s " ")
    if [ ! -z "$DOCKHOST" ]; then
        # do not use docker generated hostname
        DOCKOPTS=$(echo "$DOCKOPTS -h $DOCKHOST -e META_IMAGEREF=$IMAGENAME")
    else
        # set META_IMAGEREF (used in PS1 identifier) same as image name
        DOCKOPTS=$(echo "$DOCKOPTS -e META_IMAGEREF=$IMAGENAME")
    fi
    DOCKOPTS=$(echo "$DOCKOPTS -w `pwd`")
    ${DRYRUN} eval docker run $DOCKOPTS $IMAGENAME $COMMANDS
}
