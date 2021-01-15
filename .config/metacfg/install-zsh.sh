# Install zsh
if ! [ -x /usr/bin/zsh ]; then
    sudo apt-get --yes update
    sudo apt-get --yes install zsh
fi

if ! [ -f $HOME/.local/share/zsh/antigen.zsh ]; then
    # Install antigen
    mkdir -p $HOME/.local/share/zsh
    curl -o $HOME/.local/share/zsh/antigen.zsh -sL git.io/antigen
fi

# Set zsh as default shell
if ! [ -n "$ZSH_VERSION" ]; then
    # assumes shell other than zsh
    if [ -x /usr/bin/zsh ]; then
        sudo chsh $(whoami) -s /usr/bin/zsh
    fi
fi


