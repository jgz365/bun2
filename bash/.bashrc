PROMPT_COMMAND=_build_ps1

_build_ps1() {
  local exit_code=$?

  # ── System age (guarded against unsupported filesystems)
  local birth days_str
  birth=$(stat -c %W / 2>/dev/null)
  if [[ -n $birth && $birth -gt 0 ]]; then
    local days=$(( ($(date +%s) - birth) / 86400 ))
    days_str="[${days}d]"
  else
    days_str="[?d]"              # fs doesn't support birth time
  fi

  # ── Plain strings for accurate dot-fill math
  local plain_left="${USER}@${HOSTNAME%%.*} ╱ ${days_str} $(dirs +0)"
  local smiley_plain; [[ $exit_code -eq 0 ]] && smiley_plain=':)' || smiley_plain=':('
  local cols=${COLUMNS:-80}

  local dot_len=$(( cols - ${#plain_left} - ${#smiley_plain} - 2 ))
  [[ $dot_len -lt 1 ]] && dot_len=1
  local dots; printf -v dots "%${dot_len}s" ""
  dots="${dots// /·}"

  # ── Color variables
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
