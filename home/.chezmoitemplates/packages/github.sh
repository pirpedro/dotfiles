{{ if eq .osidlike "debian" -}}
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | {{ .cmd.sudo }} dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | {{ .cmd.sudo }} tee /etc/apt/sources.list.d/github-cli.list >/dev/null
{{ .cmd.os.update }}
{{ else if eq .osidlike "fedora" -}}
{{ .cmd.sudo }} dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
{{ else if eq .osidlike "suse" -}}
{{ .cmd.sudo }} zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
{{ .cmd.os.update }}
{{ end -}}
{{ .cmd.os.install }} gh
