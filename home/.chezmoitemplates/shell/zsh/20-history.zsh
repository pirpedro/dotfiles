#   ---------------------------
#   HISTORY
#   ---------------------------

: ${HISTFILE:=${XDG_STATE_HOME:-$HOME/.local/state}/shell/zsh_history}
: ${SAVEHIST:=200000}  # quanto salvar em disco
: ${HISTSIZE:=200000}  # quanto manter em memória
mkdir -p -- "${HISTFILE:h}" 2>/dev/null || true
export HISTFILE SAVEHIST HISTSIZE

setopt EXTENDED_HISTORY

