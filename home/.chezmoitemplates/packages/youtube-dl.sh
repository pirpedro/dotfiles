{{ if eq .chezmoi.os "darwin" }}
{{ .cmd.install }} youtube-dl
{{ else -}}
{{ .cmd.sudo }} curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
{{ .cmd.sudo}} chmod a+rx /usr/local/bin/youtube-dl
{{ end -}}
