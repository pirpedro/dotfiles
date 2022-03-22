curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s $HOME/.local/kitty.app/bin/kitty $HOME/.local/bin/
cp $HOME/.local/kitty.app/share/applications/kitty.desktop $HOME/.local/share/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
{{ if eq .env.de "gnome" }}
gsettings set org.gnome.desktop.default-applications.terminal exec $HOME/.local/bin/kitty
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ""
{{ end -}}
