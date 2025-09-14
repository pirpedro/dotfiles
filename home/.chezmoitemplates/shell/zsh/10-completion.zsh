#   ---------------------------
#   COMPLETION
#   ---------------------------

#User-level completion dirs (custom > generated > vendor)
#    Keep all your completions under ~/.local/share/completions/zsh/*
__ZC_BASE="${XDG_DATA_HOME:-$HOME/.local/share}/completions/zsh"
mkdir -p -- "${__ZC_BASE}/custom" "${__ZC_BASE}/generated" "${__ZC_BASE}/vendor"

# Prepend user dirs so they override system ones
typeset -gaU fpath
fpath=(
  "${__ZC_BASE}/custom"
  "${__ZC_BASE}/generated"
  "${__ZC_BASE}/vendor"
  $fpath
)

# Secure perms to keep compaudit quiet
chmod -R go-w "${__ZC_BASE}" 2>/dev/null || true

# compinit with per-version cache
zmodload zsh/complist 2>/dev/null || true
autoload -Uz compinit

local _zc_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
local _zc_dump="${_zc_cache}/zcompdump-${ZSH_VERSION}-${HOST}"
mkdir -p -- "${_zc_cache}"

if [[ ! -s "${_zc_dump}" || "${ZDOTDIR:-$HOME}/.zshrc" -nt "${_zc_dump}" ]]; then
  compinit -i -d "${_zc_dump}"
else
  compinit -C -i -d "${_zc_dump}"
fi

# Byte-compile para acelerar cargas futuras
[[ -s "${_zc_dump}" && ( ! -s "${_zc_dump}.zwc" || "${_zc_dump}" -nt "${_zc_dump}.zwc" ) ]] && zcompile "${_zc_dump}"

zstyle ':completion:*' rehash true
#show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2
zstyle ':completion:*:descriptions' format '%F{blue}%d%f'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=**' 'l:|=* r:|=*'
