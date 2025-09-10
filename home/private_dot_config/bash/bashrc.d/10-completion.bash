#   -------------------------------
#   COMPLETION
#   -------------------------------


# só em shell interativo
case $- in *i*) ;; *) return ;; esac

# evite recarregar
if [ -n "${__BASH_COMPLETION_LOADED:-}" ]; then
  return
fi

# POSIX mode quebra bash-completion
if shopt -oq posix; then
  return
fi

# Linux / instalações locais
if [ -r /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -r /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -r /usr/local/share/bash-completion/bash_completion ]; then
  . /usr/local/share/bash-completion/bash_completion
fi

# macOS (Homebrew)
if [ "$(uname -s)" = "Darwin" ] && command -v brew >/dev/null 2>&1; then
  # preferir o script profile.d (brew moderno)
  BRC="$(brew --prefix)/etc/profile.d/bash_completion.sh"
  if [ -r "$BRC" ]; then
    . "$BRC"
  else
    # fallbacks (brew legacy / fórmula bash-completion@2)
    [ -r "$(brew --prefix)/etc/bash_completion" ] && . "$(brew --prefix)/etc/bash_completion"
    [ -r "$(brew --prefix bash-completion)/share/bash-completion/bash_completion" ] && \
      . "$(brew --prefix bash-completion)/share/bash-completion/bash_completion"
  fi
fi

__BASH_COMPLETION_LOADED=1
