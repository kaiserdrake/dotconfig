# Set directories
ZSHCFGDIR=$HOME/.config/zsh
ZSHLCFGDIR=$HOME/.local/share/zsh

ADOTDIR=$ZSHLCFGDIR/antigen

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=$ZSHLCFGDIR/zsh_history

# General configurations
HOSTNAME=$(hostname)
setopt PROMPT_SUBST

# Load plugin manager (antigen)
source $ZSHLCFGDIR/antigen.zsh

# Fish like suggestions.
antigen bundle zsh-users/zsh-autosuggestions
# Completions
antigen bundle zsh-users/zsh-completions
# Syntax highlighting bundle.
# Note: This must be set as the last bundle in the config.
antigen bundle zsh-users/zsh-syntax-highlighting

# Tell Antigen that you're done.
antigen apply


# Load common shell configurations.
# Since the configurations were written for sh/bash, run in emulation.
[[ -e ~/.config/shell/profile.sh ]] && emulate sh -c 'source ~/.config/shell/profile.sh'

autoload -U compinit && compinit -d $ZSHLCFGDIR/zcompdump
autoload -U bashcompinit && bashcompinit

# Set prompt
source $ZSHCFGDIR/prompt.zsh-theme
