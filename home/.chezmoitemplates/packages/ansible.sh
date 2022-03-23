{{ if eq .osidlike "debian" }}
{{ .cmd.install }} software-properties-common
{{ .cmd.sudo }} apt-add-repository ppa:ansible/ansible -y
{{ .cmd.update }}
{{ .cmd.install }} ansible
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
