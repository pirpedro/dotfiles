{{ if eq .osidlike "fedora" -}}
{{ .cmd.os.install }} gnome-shell-extension-pop-shell
{{ else -}}
dir=$(mktemp -dt)
trap "rm -rf ${dir}" EXIT
git clone https://github.com/pop-os/shell.git $dir/pop-shell
make -C $dir/pop-shell local-install
{{ end -}}
# remap the launcher to Super+Space
gsettings --schemadir ~/.local/share/gnome-shell/extensions/pop-shell@system76.com/schemas set org.gnome.shell.extensions.pop-shell activate-launcher "[]"
#To disable the Super key from opening the GNOME overview:
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name '<newname>'
