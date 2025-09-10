#   Antidote (plugins)
#   ------------------------------------------------------------

ANTIDOTE_DIR="$XDG_DATA_HOME/antidote"
zsh_plugins="${ZDOTDIR:-$HOME}/.zsh_plugins"   # .txt e .zsh ficam “logicamente” aqui

#   Ensure the .zsh_plugins.txt file exists so you can add plugins.
#   ------------------------------------------------------------

[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

#   Load antidote via autoload
#   ------------------------------------------------------------

fpath=("$ANTIDOTE_DIR/functions" $fpath)
autoload -Uz antidote

#   Generate a new static file whenever .zsh_plugins.txt is updated.
#   ------------------------------------------------------------
if [[ ! "${zsh_plugins}.zsh" -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi

# (Opcional) compilar para um tiquinho mais de performance
# [[ -f "$plugins_bundle" && ! -f "${plugins_bundle}.zwc" ]] && zcompile -R -- "$plugins_bundle"

# Source your static plugins file.
source ${zsh_plugins}.zsh
