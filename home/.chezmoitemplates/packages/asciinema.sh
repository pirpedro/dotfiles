{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.install }} asciinema
{{ else -}}
{{ if not (lookPath "pip3") -}}
{{ .cmd.install }} python3-pip
{{ end -}}
{{ .cmd.sudo }} pip3 install asciinema
{{ end -}}
