{{ if eq .osidlike "debian" }}
{{ .cmd.os.install }} software-properties-common
{{ .cmd.sudo }} apt-add-repository ppa:ansible/ansible -y
{{ .cmd.os.update }}
{{ .cmd.os.install }} ansible
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
