{{ if lookPath "apt" }}
{{ .cmd.sudo }} apt -qq -y install terminator
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}