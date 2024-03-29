{{ if eq .osidlike "debian" }}
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | {{ .cmd.sudo }} apt-key add -
{{ .cmd.sudo }} sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
{{ .cmd.os.update }}
{{ .cmd.os.install }} google-chrome-stable
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
