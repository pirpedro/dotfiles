{{ if eq .osidlike "debian" -}}
{{ .cmd.sudo }} snap install figma-linux
sudo ln -s $HOME/.local/share/fonts $HOME/snap/figma-linux/current/.local/share/
{{ end -}}
