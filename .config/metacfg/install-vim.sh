# vim installation
# requires version >= 8.0 and +python
# alternatively we can use neovim

if [ -x /usr/bin/vim ]; then
    # Checking the python support based on the line output received
    has_python_support=$(vim --version | grep -c python)
    # Matching the decimal pattern from the first line
    vim_version=$(vim --version | head -1 | grep -o '[0-9]\.[0-9]')

    if [ $(echo "$vim_version < 8.2" | bc) -eq 1 ] || [ ! $has_python_support ]; then
        echo "vim version must be at least 8.2 and must be installed with python support"
        # Uninstall current vim
        sudo apt-get -y remove vim
    fi
fi

if ! [ -x /usr/bin/vim ]; then
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo apt update
    sudo apt-get -y install vim
fi

# install/update plugins
vim +'PlugInstall' +qall 2> /dev/null

