{{ if eq .osidlike "debian" }}
{{ .cmd.sudo }} apt install fonts-firacode
{{ end -}}
