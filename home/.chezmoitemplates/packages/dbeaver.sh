{{ if eq .osidlike "debian" }}
{{ .cmd.os.install }} gdebi
wget http://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb
{{ .cmd.sudo }} gdebi dbeaver-ce_latest_amd64.deb
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
