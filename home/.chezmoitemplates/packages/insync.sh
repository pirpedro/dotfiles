{{ if eq .osidlike "debian" -}}
{{ .cmd.sudo }} apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
echo "deb http://apt.insync.io/{{ .chezmoi.osidlike }} {{ .chezmoi.osRelease.versionCodename }} non-free contrib" | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/insync.list
{{ .cmd.os.update }}
{{ .cmd.os.install }} insync
{{ end -}}
