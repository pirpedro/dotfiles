{{ if eq .osidlike "debian" }}
{{ .cmd.sudo }} add-apt-repository ppa:agornostal/ulauncher -y
{{ .cmd.sudo }} apt update -y
{{ .cmd.sudo }} apt -qq -y install ulauncher python3-pip
pip3 install bs4 simpleeval pint faker validator-collection parsedatetime --user
pip3 install --user "algoliasearch>=2.0,<3.0"
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
