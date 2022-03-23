{{/* A file previewer for the GNOME desktop environment. */ -}}
{{ if eq .env.de "gnome" }}
{{ .cmd.install }} gnome-sushi
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
