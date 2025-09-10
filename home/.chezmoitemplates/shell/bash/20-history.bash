#   -------------------------------
#   HISTORY
#   -------------------------------


: "${XDG_STATE_HOME:=$HOME/.local/state}"
HISTFILE="$XDG_STATE_HOME/shell/bash_history"

mkdir -p "$(dirname -- "$HISTFILE")"

# comportamento do histórico
# - ignora linhas que começam com espaço
# - evita duplicatas consecutivas
# - remove duplicatas antigas ao adicionar uma nova igual
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTSIZE=200000
HISTFILESIZE=200000

# salva cada comando imediatamente e lê novas entradas de outras sessões
# (history -a = append; history -n = ler novas linhas de HISTFILE)
shopt -s histappend
PROMPT_COMMAND='history -a; history -n; '"$PROMPT_COMMAND"

# registra timestamp nas entradas
HISTTIMEFORMAT='%F %T '

# útil para histórico com múltiplas linhas de comando
shopt -s cmdhist

# ajusta LINES/COLUMNS quando necessário
shopt -s checkwinsize

# lesspipe (portável)
if command_exists lesspipe ; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# globstar é opcional; ative se você usa ** com frequência
# shopt -s globstar

