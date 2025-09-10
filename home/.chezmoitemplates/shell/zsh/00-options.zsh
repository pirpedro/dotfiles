#   ---------------------------
#   ENVIRONMENT (ONLY FOR INTERACTIVE SESSIONS)
#   ---------------------------

#   Antidote (plugins)
#   ------------------------------------------------------------

#   Navegação & globbing
#   ------------------------------------------------------------

setopt AUTO_CD           # cd só digitando o nome do diretório
# Directory (prezto:directory)
setopt AUTO_CD AUTO_PUSHD PUSHD_SILENT PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB     # padrões de glob mais poderosos

#   History
#   ------------------------------------------------------------
setopt HIST_IGNORE_DUPS  # ignora duplicadas consecutivas
setopt HIST_IGNORE_SPACE # não grava linhas que começam com espaço
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY     # compartilha histórico entre sessões
setopt INC_APPEND_HISTORY_TIME



#   Optionals
#   ------------------------------------------------------------
setopt INC_APPEND_HISTORY_TIME   # grava a cada comando (com timestamp)
setopt HIST_REDUCE_BLANKS        # comprime espaços
setopt HIST_VERIFY               # confirma expansão de ! antes de executar


