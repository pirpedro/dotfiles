# helpers POSIX para organizar carregamento e PATH
[ -n "${__SHELL_BOOTSTRAP_SOURCED+x}" ] && return 0
__SHELL_BOOTSTRAP_SOURCED=1

command_exists() { command -v "$1" >/dev/null 2>&1; }

which_bin() { command -v "$1" 2>/dev/null; }

add_path() { case ":$PATH:" in *":$1:"*) :;; *) PATH="$1:$PATH";; esac; }

dedupe_path() {
  old="$PATH"; PATH=""; IFS=:
  for p in $old; do [ -n "$p" ] && add_path "$p"; done
  unset IFS
}

is_bash() { [ -n "${BASH_VERSION-}" ]; }
is_zsh()  { [ -n "${ZSH_VERSION-}"  ]; }

source_dir() {
  dir=${1%/}
  [ -d "$dir" ] || return 0

  # tmpfile para listar os arquivos (evita pipeline/subshell)
  if command -v mktemp >/dev/null 2>&1; then
    tmp=$(mktemp -t sourcedir.XXXXXX) || tmp="${TMPDIR:-/tmp}/sourcedir.$$"
  else
    tmp="${TMPDIR:-/tmp}/sourcedir.$$"
  fi

  # limpa o tmp em sinais e saída
  trap 'rm -f "$tmp"' INT TERM EXIT

  # Tenta GNU/BSD find com -maxdepth; se não houver, cai para glob
  if find "$dir" -maxdepth 1 -type f -print >/dev/null 2>&1; then
    find "$dir" -maxdepth 1 -type f \
      \( -name '*.sh' -o -name '*.zsh' -o -name '*.bash' \) \
      \! -name '*~' \! -name '*.swp' \! -name '*.tmp' -print > "$tmp"
  else
    # Fallback: glob (sem descer diretórios)
    set -f
    : > "$tmp"
    for f in "$dir"/*.sh "$dir"/*.zsh "$dir"/*.bash; do
      [ -f "$f" ] || continue
      case $f in *~|*.swp|*.tmp) continue ;; esac
      printf '%s\n' "$f" >> "$tmp"
    done
    set +f
  fi

  # Ordena se sort existir (opcional)
  if command -v sort >/dev/null 2>&1; then
    # tenta in-place; se não der, usa arquivo provisório
    if ! sort -o "$tmp" "$tmp" 2>/dev/null; then
      if command -v mktemp >/dev/null 2>&1; then
        tmp2=$(mktemp -t sourcedir.XXXXXX) || tmp2="$tmp.sorted"
      else
        tmp2="$tmp.sorted"
      fi
      sort "$tmp" >"$tmp2" && mv "$tmp2" "$tmp"
    fi
  fi

  # Lê a lista por redirecionamento (sem pipeline → sem subshell)
  while IFS= read -r f; do
    [ -r "$f" ] || continue
    [ -n "${SOURCE_DIR_DEBUG-}" ] && printf 'source %s\n' "$f" >&2
    . "$f" || printf 'warn: %s falhou\n' "$f" >&2
  done < "$tmp"

  rm -f "$tmp"
  trap - INT TERM EXIT
}

is_interactive() {
  case "$-" in
    *i*) return 0 ;;                  # quase todos os shells marcam 'i' em $-
  esac
  [ -n "${PS1-}" ] && [ -t 0 ] && return 0   # fallback: prompt set + TTY
  return 1
}

is_login_shell() {
  case "$0" in
    -*) return 0 ;;                   # argv0 começando com '-' => login shell
  esac
  # bash expõe um teste próprio:
  if [ -n "${BASH_VERSION-}" ] 2>/dev/null; then
    shopt -q login_shell 2>/dev/null && return 0
  fi
  return 1
}

. "$HOME/.config/shell/common.sh"

if is_interactive; then
  . "$HOME/.config/shell/interactive.sh"
fi

if is_login_shell; then
  source_dir $HOME/.config/shell/login.d
fi
