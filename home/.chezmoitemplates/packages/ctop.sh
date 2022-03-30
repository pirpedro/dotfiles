{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.os.install }} ctop
{{ else -}}
{{ .cmd.sudo }} wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
{{ .cmd.sudo }} chmod +x /usr/local/bin/ctop
{{ end -}}
