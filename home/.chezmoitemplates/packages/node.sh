{{ if eq .osidlike "debian" }}
mkdir -p $HOME/"{{ .path.npm.global }}"
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
{{ .cmd.install }} nodejs
npm install npm@latest -g --prefix $HOME/{{ .path.npm.global }}
{{ else -}}
echo "No installation descriptor for this distro."
{{ end -}}
