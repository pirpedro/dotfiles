{{ if eq .osidlike "debian" }}
mkdir -p {{ .path.node.global }}
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
{{ .cmd.os.install }} nodejs
{{ .cmd.node.install }} npm@latest
{{ else -}}
echo "No installation descriptor for this distro."
{{ end -}}
