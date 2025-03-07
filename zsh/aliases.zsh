alias cls="clear"
alias sshcolor="TERM=xterm-256color ssh"
alias updatearch="sudo pacman -Syu"
alias cleandockerimages='sudo docker rmi $(sudo docker images --filter "dangling=true" -q --no-trunc)'
alias runsshagent='eval "$(ssh-agent -s)"'
alias ncdu="ncdu --color dark"
alias diskutil='sudo ncdu --color dark --exclude=/mnt /'

# check for the commands before using the following aliases
if [ -x "$(command -v eza)" ]; then
  alias ls="eza"
fi

if [ -x "$(command -v bat)" ]; then
  alias cat="bat"
fi

if [ -x "$(command -v nvim)" ]; then
  alias vi="nvim"
fi
