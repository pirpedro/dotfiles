{{/* A file previewer for the GNOME desktop environment. */ -}}
{{ if .osidlike "debian" }}
{{ .cmd.sudo }} apt install -y gnome-sushi
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
