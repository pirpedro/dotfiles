{{- if eq .chezmoi.os "darwin" }}
{{ .cmd.os.install }} --cask visual-studio-code
{{- else if eq .chezmoi.os "linux" }}
{{- if eq .osidlike "debian" }}
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/vscode.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
{{ .cmd.sudo }} mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
{{- else if eq .osidlike "fedora" "centos"}}
{{ .cmd.sudo }} rpm --import https://packages.microsoft.com/keys/microsoft.asc
{{ .cmd.sudo }} sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
{{- else if eq .osidlike "suse" }}
{{ .cmd.sudo }} rpm --import https://packages.microsoft.com/keys/microsoft.asc
{{ .cmd.sudo }} sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/zypp/repos.d/vscode.repo'
{{- end }}
{{ .cmd.os.update }}
{{ .cmd.os.install }} code
{{ .cmd.sudo }} chown -R $(whoami) /usr/share/code
{{- else }}
echo "No installation descriptor for this distro."
{{- end }}
