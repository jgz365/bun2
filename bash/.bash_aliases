# My personal bash aliases.
# © jgz365
# Ubuntu 24.04.4 LTS

# VIM 
alias @editor='vim'
alias @ebash='@editor $HOME/.bash_aliases'
alias @erc='@editor $HOME/.bashrc'
alias @vocoder='@editor $HOME/.vimrc'

# Bash Management
alias @read='cat $HOME/.bash_aliases'
alias @zrel='source $HOME/.bashrc'
alias @load='history | less'
alias @reset='cat /dev/null > ~/.bash_history'

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Personal Files
alias cdir='cd $HOME/Desktop/journey-to-the-Cnter/'

# APT
alias @sync='sudo apt update'
alias @world='sudo apt upgrade'
alias @package='sudo apt install'
alias @fullpkg='sudo apt install --install-recommends'
alias @lesspkg='sudo apt install --no-install-recommends'
alias @rempkg='sudo apt remove'
alias @kill='sudo apt purge'
alias @eclean='sudo apt autoremove && sudo apt autoclean'
alias @browse='apt search'
alias @info='apt show'
alias @bworld='apt list --installed 2>/dev/null'

# Snap 
alias @sbox='snap'

# System
alias cat='batcat'
alias @top='htop'
alias @disk='df -h'
alias @mem='free -h'
alias @ports='ss -tulnp'
