{{ if eq .osidlike "debian" -}}
echo 'deb [trusted=yes] https://repo.goreleaser.com/apt/ /' | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/goreleaser.list
{{ .cmd.os.update}}
{{ else if eq .osidlike "fedora" -}}
echo '[goreleaser]
name=GoReleaser
baseurl=https://repo.goreleaser.com/yum/
enabled=1
gpgcheck=0' | {{ .cmd.sudo }} tee /etc/yum.repos.d/goreleaser.repo
{{ end -}}
{{ .cmd.os.install }} goreleaser
