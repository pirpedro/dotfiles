#   --------------------------------------------------------------------------
#   SSH Agent
#   --------------------------------------------------------------------------

#   kitty
#   ------------------------------------------------------------
{{ if not .is.headless -}}
  command_exists kitty && alias ssh='kitty +kitten ssh'
{{ end -}}

for sock in \
  "$HOME/.bitwarden-ssh-agent.sock" \
  "$HOME/snap/bitwarden/current/.bitwarden-ssh-agent.sock" \
  "$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock" \
  "$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
do
  if [ -S "$sock" ]; then
    export SSH_AUTH_SOCK="$sock"
    break
  fi
done
