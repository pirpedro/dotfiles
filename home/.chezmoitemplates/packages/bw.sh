{{ if eq .osidlike "debian" }}
npm install -g @bitwarden/cli --prefix $HOME/{{ .path.npm.global }}
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
