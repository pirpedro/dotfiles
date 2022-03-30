#File for configuring program specific solutions.

if which rbenv >/dev/null; then eval "$(rbenv init -)"; fi

shell_name=$(basename $(/bin/sed -r -e 's/\x0.*//' /proc/$$/cmdline))
eval "$(direnv hook ${shell_name})"
