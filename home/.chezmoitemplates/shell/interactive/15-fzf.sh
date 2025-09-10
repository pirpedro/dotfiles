# keybindings/config do fzf (se instalado)

if [ -n "${ZSH_VERSION-}" ]; then
  shell_name=zsh
elif [ -n "${BASH_VERSION-}" ]; then
  shell_name=bash
else
  # fallback sem /proc (macOS/BSD)
  shell_name="$(ps -p $$ -o comm= 2>/dev/null | sed 's/^-//')"
fi

if [ -d "$HOME/.fzf/bin" ]; then
  add_path "$HOME/.fzf/bin"
  dedupe_path
fi

# 3) Onde ficam os arquivos shell do fzf?
FZF_SHELL_DIR=""
for d in "$HOME/.fzf" "/usr/share/fzf" "/usr/local/opt/fzf" "/opt/homebrew/opt/fzf"; do
  if [ -d "$d/shell" ]; then
    FZF_SHELL_DIR="$d/shell"
    break
  fi
done

# 4) Só em shell interativo carregue completion
case $- in
  *i*)
    # completion (se existir)
    if [ -n "$FZF_SHELL_DIR" ] && [ -r "$FZF_SHELL_DIR/completion.$shell_name" ]; then
      . "$FZF_SHELL_DIR/completion.$shell_name"
    fi
    ;;
esac

# 5) Key bindings (normalmente ok em não-interativo, mas só carrego se existir)
if [ -n "$FZF_SHELL_DIR" ] && [ -r "$FZF_SHELL_DIR/key-bindings.$shell_name" ]; then
  . "$FZF_SHELL_DIR/key-bindings.$shell_name"
fi

# 6) Opções padrão (ajuste à vontade)
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:---height 40% --border}"


# bind 'set mark-symlinked-directories on' 2>/dev/null

# fzf_marks=$HOME/.local/share/zprezto/contrib/fzf-marks/fzf-marks.plugin.bash
# if [ -e "$fzf_marks" ]; then
#   source "$fzf_marks"
# fi
