{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.os.install }} --cask lens
{{ else if eq .osidlike "debian" }}
dir=$(mktemp -dt)
trap "rm -rf ${dir}" EXIT
curl -L https://api.k8slens.dev/binaries/Lens-5.4.5-latest.20220405.1.amd64.deb -o "$dir/lens.deb"
{{ .cmd.sudo }} dpkg -i "$dir/lens.deb"
{{ end -}}
