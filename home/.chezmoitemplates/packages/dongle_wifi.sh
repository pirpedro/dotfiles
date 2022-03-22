{{ if .osidlike "debian" }}
git clone "https://github.com/RinCat/RTL88x2BU-Linux-Driver.git" ~/.local/src/rtl88x2bu-git
sed -i 's/PACKAGE_VERSION="@PKGVER@"/PACKAGE_VERSION="git"/g' ~/.local/src/rtl88x2bu-git/dkms.conf
cd ~/.local/src/rtl88x2bu-git
{{ .cmd.sudo }} rsync --delete --exclude=.git -rvhP ~/.local/src/rtl88x2bu-git/ "/usr/src/rtl88x2bu-git"
rm -rf ~/.local/src/rtl88x2bu-git
{{ .cmd.sudo }} dkms add -m rtl88x2bu -v git
{{ .cmd.sudo }} dkms autoinstall
{{ .cmd.sudo }} modprobe 88x2bu
{{ else }}
echo "No installation descriptor for this distro."
{{ end -}}
