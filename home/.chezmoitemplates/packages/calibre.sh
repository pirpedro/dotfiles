{{ if lookPath "apt" }}
{{ .cmd.sudo }} apt -qq -y install calibre
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}