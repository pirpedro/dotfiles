#   ---------------------------
#   COMPLETION
#   ---------------------------

# compinit com cache no XDG_CACHE_HOME
autoload -Uz compinit
local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
dump="${cache_dir}/zcompdump-${ZSH_VERSION}-${HOST}"
mkdir -p -- "$cache_dir" 2>/dev/null || true

if [[ ! -s "$dump" || "$ZDOTDIR/.zshrc" -nt "$dump" ]]; then
  compinit -i -d "$ZCACHED"
else
  compinit -C -i -d "$ZCACHED"
fi

# Byte-compile para acelerar cargas futuras
[[ -s "$dump" && ( ! -s "${dump}.zwc" || "$dump" -nt "${dump}.zwc" ) ]] && zcompile "$dump"

zmodload zsh/complist 2>/dev/null || true
zstyle ':completion:*' rehash true
#show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2
