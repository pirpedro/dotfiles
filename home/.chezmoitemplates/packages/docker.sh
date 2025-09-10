{{ if eq .osidlike "debian" }}
{{ .cmd.os.install }} ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | {{ .cmd.sudo }} gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/docker.list >/dev/null
{{ .cmd.os.update }}
{{ .cmd.os.install }} docker-ce docker-ce-cli containerd.io
{{ .cmd.sudo }} groupadd docker
{{ .cmd.sudo }} usermod -aG docker $USER
newgrp docker
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
