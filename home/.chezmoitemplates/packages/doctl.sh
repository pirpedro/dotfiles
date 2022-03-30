{{ if eq .chezmoi.os "darwin " -}}
{{ .cmd.os.install }} doctl
{{ else -}}
curl -L https://github.com/digitalocean/doctl/releases/download/v1.72.0/doctl-1.72.0-linux-{{ .chezmoi.arch }}.tar.gz | {{ .cmd.sudo }} tar xvz -C /usr/local/bin
{{ end -}}
