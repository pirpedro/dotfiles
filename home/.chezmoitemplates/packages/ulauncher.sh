{{ if eq .osidlike "debian" -}}
{{ .cmd.sudo }} add-apt-repository ppa:agornostal/ulauncher -y
{{ .cmd.os.update }}
{{ .cmd.os.install }} ulauncher python3-pip
pip3 install bs4 simpleeval pint faker validator-collection parsedatetime --user
pip3 install --user "algoliasearch>=2.0,<3.0"
{{ if lookPath "systemctl" }}
systemctl --user enable --now ulauncher
{{ end -}}
{{ else -}}
echo "No installation descriptor for this distro."
{{ end -}}
