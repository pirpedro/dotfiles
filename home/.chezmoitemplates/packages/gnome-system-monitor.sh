{{ if eq .osidlike "debian" -}}
{{ .cmd.os.install }} gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor
{{ else if eq .osidlike "fedora" -}}
{{ .cmd.os.install }} libgtop2-devel NetworkManager-libnm-devel gnome-system-monitor
{{ else if eq .osidlike "arch" -}}
{{ .cmd.os.install }} libgtop networkmanager gnome-system-monitor clutter
{{ else if eq .osidlike "suse" -}}
{{ .cmd.os.install }} gnome-shell-devel libgtop-devel libgtop-2_0-10 gnome-system-monitor
{{ end -}}
