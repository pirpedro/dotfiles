{{ if eq .osidlike "debian" }}
curl -1sLf \
  'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' |
  {{ .cmd.sudo }} -E distro={{.chezmoi.osRelease.id}} version={{.chezmoi.osRelease.versionID}} codename={{.chezmoi.osRelease.versionCodename}} arch={{.chezmoi.arch}} bash
{{ .cmd.sudo }} apt install -y balena-etcher-electron
touch $HOME/.local/bin/etcher #dummy file to check if etcher is already installed
chmod +x $HOME/.local/bin/etcher
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
