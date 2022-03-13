{{ if lookPath "apt" }}
{{ .cmd.sudo }} apt install fonts-firacode
{{ end -}}