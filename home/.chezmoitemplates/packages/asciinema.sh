{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.os.install }} asciinema
{{ else -}}
{{ if not (lookPath "pip3") -}}
{{ .cmd.os.install }} python3-pip
{{ end -}}
{{ .cmd.sudo }} pip3 install asciinema
{{ end -}}
