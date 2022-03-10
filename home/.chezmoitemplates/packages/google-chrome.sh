{{ if lookPath "apt" }}
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | {{ .cmd.sudo }} apt-key add -
{{ .cmd.sudo }} sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
{{ .cmd.sudo }} apt update -y
{{ .cmd.sudo }} apt -qq -y install google-chrome-stable
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}