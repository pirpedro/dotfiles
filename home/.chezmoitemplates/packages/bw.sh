{{ if lookPath "apt" }}
npm install -g @bitwarden/cli --prefix $HOME/{{ .path.npm.global }}
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}