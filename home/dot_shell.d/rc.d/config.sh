#environment

export CLICOLOR=1
export TERM=xterm-256color
export GPG_TTY=$(tty)
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export BROWSER=google-chrome
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#if running bash
if [ -n "$BASH_VERSION" ]; then
  #enable symlinks autocomplete with dash
  bind 'set mark-symlinked-directories on' 2>/dev/null

  [ -f /usr/local/share/bash-completion/bash_completion ] && . /usr/local/share/bash-completion/bash_completion
fi