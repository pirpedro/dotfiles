{{ if lookPath "apt" }}
{{ .cmd.sudo }} apt -qq -y install neovim
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
