# Setup fzf
# ---------

if [[ -d $HOME/.fzf ]]; then
  shell_name=$(basename $(/bin/sed -r -e 's/\x0.*//' -e 's/-//' /proc/$$/cmdline))
  if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.${shell_name}" 2>/dev/null

  # Key bindings
  # ------------
  source "$HOME/.fzf/shell/key-bindings.${shell_name}"

fi
