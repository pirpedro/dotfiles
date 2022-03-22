{{ if eq .chezmoi.os "darwin" -}}
brew install git-delta
{{ else if eq .osidlike "debian" -}}
version="0.12.1"
dir=${TMPDIR:=$(mktemp -dt)}
trap "rm -rf ${dir}" EXIT
curl -L https://github.com/dandavison/delta/releases/download/${version}/git-delta_${version}_{{ .chezmoi.arch }}.deb -o "$dir/git-delta.deb"
{{ .cmd.sudo }} dpkg -i "$dir/git-delta.deb"
{{ else if eq .chezmoi.osRelease.idLike "arch" -}}
{{ .cmd.sudo }} pacman -S git-delta
{{ else if eq .chezmoi.osRelease.idLike "fedora" -}}
{{ .cmd.sudo }} dnf install git-delta
{{ else -}}
echo "No installation descriptor for this distro."
{{ end -}}
