tmpdir=${TMPDIR:=$(mktemp -dt)}
wget -O "$tmpdir/"gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
chmod +x "$tmpdir/"gnome-shell-extension-installer
mv "$tmpdir"/gnome-shell-extension-installer "$HOME"/.local/bin/
