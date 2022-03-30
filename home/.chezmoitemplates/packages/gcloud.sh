{{ if eq .chezmoi.os "darwin" -}}
{{ .cmd.os.install }} --cask google-cloud-sdk
{{ else if eq .osidlike "debian" -}}
{{ .cmd.os.install }} apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | {{ .cmd.sudo }} tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | {{ .cmd.sudo }} tee /usr/share/keyrings/cloud.google.gpg
{{ .cmd.os.update }}
{{ else if eq .osidlike "fedora" -}}
{{ .cmd.sudo }} tee -a /etc/yum.repos.d/google-cloud-sdk.repo <<EOM
[google-cloud-cli]
name=Google Cloud CLI
baseurl=https://packages.cloud.google.com/yum/repos/cloud-sdk-el8-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
       https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOM
{{ .cmd.os.install }} libxcrypt-compat.x86_64
{{ end -}}
{{ .cmd.os.install }} google-cloud-cli
