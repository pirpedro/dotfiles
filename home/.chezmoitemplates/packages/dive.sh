{{ if eq .chezmoi.os "darwin " -}}
{{ .cmd.os.install }} dive
{{ else -}}
dir=$(mktemp -dt)
trap "rm -rf ${dir}" EXIT
{{ if eq .osidlike "debian" -}}
curl -L https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.deb >>$dir/dive.deb
{{ .cmd.os.install }} $dir/dive.deb
{{ else if eq .osidlike "fedora" -}}
curl -OL https://github.com/wagoodman/dive/releases/download/v0.9.2/dive_0.9.2_linux_amd64.rpm
rpm -i dive_0.9.2_linux_amd64.rpm
{{ end -}}
{{ end -}}
