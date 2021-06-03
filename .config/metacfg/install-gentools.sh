# Set default shell to bash
echo dash dash/sh boolean false | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

sudo apt-get --yes update
sudo DEBIAN_FRONTEND=noninteractive apt-get --yes upgrade

# Install common development tools
# Refrain from installing all tools natively to the host,
# consider creating build-environment containers
sudo apt-get --yes install \
    exuberant-ctags \
    net-tools \
    tmux \
    trash-cli \
    tree \
    xclip

# FZF
# Upon failure, download deb package and install it manually.
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# ripgrep
# ripgrep is available in some officiak distribution repository.
# Try to install it from official package repository.
# Upon failure, download deb package and install it manually.
sudo apt-get --yes install ripgrep
if ! [ -x /usr/bin/rg ]; then
    mkdir -p /tmp; pushd /tmp
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
    sudo dpkg -i ripgrep_11.0.2_amd64.deb
    rm ripgrep_11.0.2_amd64.deb
    popd
fi
