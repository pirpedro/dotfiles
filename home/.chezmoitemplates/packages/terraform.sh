{{ if eq .chezmoi.os "darwin" -}}
brew tap hashicorp/tap
{{ .cmd.os.install }} hashicorp/tap/terraform
{{ else -}}
{{ if eq .osidlike "debian" }}
{{ .cmd.os.install }} gnupg software-properties-common
curl -fsSL https://apt.releases.hashicorp.com/gpg | {{ .cmd.sudo }} apt-key add -
{{ .cmd.sudo }} apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
{{ .cmd.os.update}}
{{ else if eq .osidlike "centos" }}
{{ .cmd.os.install }} yum-utils
{{ .cmd.sudo }} yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
{{ else if eq .osidlike "fedora" }}
{{ .cmd.os.install }} dnf-plugins-core
{{ .cmd.sudo }} dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
{{ end -}}
{{ .cmd.os.install }} terraform
{{ end -}}
