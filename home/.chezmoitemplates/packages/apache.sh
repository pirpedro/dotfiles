{{ if eq .osidlike "debian" }}
{{ .cmd.sudo }} apt -y -qq install apache2
{{ .cmd.sudo }} ufw allow in "Apache Full"
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
