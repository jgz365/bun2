PROMPT_COMMAND=_build_ps1

_build_ps1() {
  local exit_code=$?

  local user_host_dir="${USER}@${HOSTNAME%%.*} ╱ $(dirs +0)"
  local cols=${COLUMNS:-80}

  local smiley_plain=':)'
  [[ $exit_code -ne 0 ]] && smiley_plain=':('

  local dot_len=$(( cols - ${#user_host_dir} - ${#smiley_plain} - 2 ))
  [[ $dot_len -lt 1 ]] && dot_len=1
  local dots; printf -v dots "%${dot_len}s" ""
  dots="${dots// /·}"

  local ok='\[\e[32m\]:)\[\e[m\]'
  local err='\[\e[31m\]:(\[\e[m\]'
  local smiley; [[ $exit_code -eq 0 ]] && smiley=$ok || smiley=$err

  local dim_dots="\[\e[2;37m\]${dots}\[\e[0m\]"

  PS1='\n'
  PS1+='\[\e[35m\]\u\[\e[2;37m\]@\[\e[0;36m\]\h\[\e[0m\]'
  PS1+=' \[\e[2;37m\]╱\[\e[0m\] \[\e[37m\]\w\[\e[0m\]'
  PS1+=" ${dim_dots} ${smiley}"
  PS1+='\n\[\e[35m\]❯\[\e[0m\] '
}

# cd + ls combination
cd () {
    builtin cd "$@" && ls --color=auto -A
}
