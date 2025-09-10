#   ---------------------------
#   ENVIRONMENT (ONLY FOR INTERACTIVE SESSIONS)
#   ---------------------------

#   Add color to terminal
#   ------------------------------------------------------------

case "$TERM" in
  xterm*|screen*|tmux*|rxvt*|alacritty*|foot*|kitty*)
    [ "${TERM#*-256color}" != "" ] && TERM=xterm-256color
    export TERM
    ;;
esac

if command_exists vivid; then
  export LS_COLORS="$(vivid generate molokai)"
fi

#   Use bat for man if available (pure UX)
#   ------------------------------------------------------------
if command_exists {{ .cmd.bat }}; then
  export MANPAGER='sh -c "col -bx | {{ .cmd.bat }} -l man -p"'
  export BAT_THEME='Dracula'
fi

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCK_SIZE=1k

export DIRENV_LOG_FORMAT="direnv: %s"

if command_exists pspg; then
  export PSQL_PAGER='pspg -X -b --no-mouse --force-uniborder'
else
  export PSQL_PAGER='less -RSFX'
fi

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/ripgreprc"

export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
