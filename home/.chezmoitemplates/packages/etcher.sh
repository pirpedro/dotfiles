{{ if lookPath "apt" }}
curl -1sLf \
  'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' |
  {{ .cmd.sudo }} -E distro=some-distro codename=some-codename arch=some-arch bash
{{ .cmd.sudo }} apt install -y balena-etcher-electron
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
