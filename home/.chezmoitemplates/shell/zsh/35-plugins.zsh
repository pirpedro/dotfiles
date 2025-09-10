typeset -ga ZSH_HIGHLIGHT_HIGHLIGHTERS
ZSH_HIGHLIGHT_HIGHLIGHTERS=(
  main
  brackets
  pattern
  line
  cursor
  root
)

# exemplos de patterns (opcional):
typeset -gA ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm * -rf *' 'fg=white,bold,bg=red')

# Auto title (prezto:terminal)
# Formats inspirados no teu .zpreztrc:
#  window: '%n@%m: %s'   tab: '%m: %s'
precmd() {
  local user=${USER:-${LOGNAME:-u}}
  local host=${HOST%%.*}
  local s="${PWD/#$HOME/~}"
  # window title
  print -Pn -- "\e]2;$user@$host: $s\a"
  # tab title
  print -Pn -- "\e]1;$host: $s\a"
}
preexec() {
  local user=${USER:-${LOGNAME:-u}}
  local host=${HOST%%.*}
  local cmd=${1%% *}
  print -Pn -- "\e]2;$user@$host: $cmd\a"
  print -Pn -- "\e]1;$host: $cmd\a"
}
