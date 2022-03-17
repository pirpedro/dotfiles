{{ if lookPath "apt" }}
echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/vscode.list
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
{{ .cmd.sudo }} mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
{{ .cmd.sudo }} apt update
{{ .cmd.sudo }} apt -qq -y install code
{{ .cmd.sudo }} chown -R $(whoami) /usr/share/code
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
