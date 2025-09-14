#   ---------------------------
#   HISTORY
#   ---------------------------

export HISTFILE="$XDG_STATE_HOME/shell/zsh_history"
mkdir -p -- "${HISTFILE:h}" 2>/dev/null || true
export SAVEHIST=200000  # quanto salvar em disco
export HISTSIZE=200000  # quanto manter em memória

# ---- Snapshot behavior:
setopt APPEND_HISTORY        # grava ao sair (append, sem truncar)
setopt INC_APPEND_HISTORY    # grava no arquivo à medida que você executa comandos
setopt SHARE_HISTORY       #  importa em tempo real o que outras sessões escreverem

setopt HIST_FCNTL_LOCK       # evita corrupção do arquivo com múltiplas sessões
setopt EXTENDED_HISTORY      # timestamps no arquivo de histórico
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
