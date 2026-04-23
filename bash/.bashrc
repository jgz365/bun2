#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Aliases

# VIM 
alias @ebash='@editor $HOME/.bashrc'
alias @vocoder='@editor $HOME/.vimrc'

# Bash Management
alias @read='bat $HOME/.bashrc'
alias @zrel='source $HOME/.bashrc'
alias @load='history | less'
alias @reset='history -c && history -w'

# Directory Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Pacman
alias @esync="sudo pacman -Syy"
alias @world='sudo pacman -Syu'
alias @package='sudo pacman -S'
alias @remnant='sudo pacman -R'
alias @eclean='sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null && sudo pacman -Sc'
alias @browse='pacman -Ss'
alias @info='pacman -Si'

# System
alias @top='htop'
alias @disk='df -h'
alias @mem='free -h'
alias @ports='ss -tulnp'

PROMPT_COMMAND=_build_ps1

_build_ps1() {
  local exit_code=$?

  local birth days_str
  birth=$(stat -c %W / 2>/dev/null)
  if [[ -n $birth && $birth -gt 0 ]]; then
    local days=$(( ($(date +%s) - birth) / 86400 ))
    days_str="[${days}d]"
  else
    days_str="[?d]"
  fi

  local plain_left="${USER}@${HOSTNAME%%.*} ╱ ${days_str} $(dirs +0)"
  local smiley_plain; [[ $exit_code -eq 0 ]] && smiley_plain=':)' || smiley_plain=':('
  local cols=${COLUMNS:-80}

  local dot_len=$(( cols - ${#plain_left} - ${#smiley_plain} - 2 ))
  [[ $dot_len -lt 1 ]] && dot_len=1
  local dots; printf -v dots "%${dot_len}s" ""
  dots="${dots// /·}"

  local c_user='\[\e[35m\]' c_host='\[\e[36m\]'
  local c_dim='\[\e[2;37m\]' c_dir='\[\e[37m\]'
  local c_rst='\[\e[0m\]' c_sym='\[\e[35m\]'
  local ok='\[\e[32m\]:)\[\e[m\]'
  local err='\[\e[31m\]:(\[\e[m\]'
  local smiley; [[ $exit_code -eq 0 ]] && smiley=$ok || smiley=$err

  PS1='\n'
  PS1+="${c_user}\u${c_dim}@${c_host}\h${c_rst}"
  PS1+=" ${c_dim}╱${c_rst} "
  PS1+="${c_dim}${days_str}${c_rst} "  # dimmed [42d]
  PS1+="${c_dir}\w${c_rst}"
  PS1+=" ${c_dim}${dots}${c_rst} ${smiley}"
  PS1+='\n'
  PS1+="${c_sym}❯${c_rst} "
}

# cd + ls combination
cd () {
    builtin cd "$@" && ls --color=auto -A
}

# Git status from https://github.com/magicmonty/bash-git-prompt
if [ -f "$HOME/.bash-git-prompt/gitprompt.sh" ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$HOME/.bash-git-prompt/gitprompt.sh"
fi
