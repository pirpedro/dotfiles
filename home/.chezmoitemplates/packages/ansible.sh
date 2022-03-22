{{ if .osidlike "debian" }}
{{ .cmd.sudo }} apt -qq -y install software-properties-common
{{ .cmd.sudo }} apt-add-repository ppa:ansible/ansible -y
{{ .cmd.sudo }} apt update -y
{{ .cmd.sudo }} apt -qq -y install ansible -y
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
