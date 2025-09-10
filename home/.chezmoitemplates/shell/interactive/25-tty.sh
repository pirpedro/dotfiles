[ -t 1 ] && export GPG_TTY="$(tty)"

: "${LESS:="-F -g -i -M -R -S -w -X"}"; export LESS

# Enable lesspipe/lesspipe.sh if available (bash/zsh/posix)
#   ------------------------------------------------------------

eval "$(lesspipe)"

# if command_exists lesspipe; then
#   eval "$(SHELL=/bin/sh lesspipe)"
# elif command_exists lesspipe.sh; then
#   eval "$(lesspipe.sh)"
# fi





