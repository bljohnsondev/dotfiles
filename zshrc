export EDITOR=nvim
export PATH=$HOME/bin:/usr/local/bin:$HOME/go/bin:/opt/nvim/bin:$HOME/.cargo/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export GOPATH=$HOME/go

ZSH_THEME="steeef"

plugins=(
  git
  vi-mode
)

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

source $ZSH/oh-my-zsh.sh

# for tmux/tmuxp
export DISABLE_AUTO_TITLE="true"

# node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/completion.zsh
source ~/.config/zsh/searchfix.zsh

# see distro specific rc settings
if (( $+commands[apt-get] )); then
  source ~/.config/zsh/debian.zsh
fi

# add any local config if it exists
if [ -f $HOME/.config/zsh/local.zsh ]; then
  source ~/.config/zsh/local.zsh
fi
