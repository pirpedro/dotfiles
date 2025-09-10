{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.os.install }} mitmproxy
{{ else -}}
{{ end -}}

set +f
version=8.0.0
tmp_dir=$(mktemp -dt)
trap 'rm -rf ${tmp_dir}' EXIT
curl -L https://snapshots.mitmproxy.org/${version}/mitmproxy-${version}-linux.tar.gz | tar xz -C "${tmp_dir}" && {{ .cmd.sudo }} chmod +x ${tmp_dir}/* && {{ .cmd.sudo }} mv ${tmp_dir}/* /usr/local/bin/
set -f
