#!/bin/bash

. $HOME/.config/bash/bash_includes

function break-pane(){
    tmux break-pane -n `generate-name`
}

$1
