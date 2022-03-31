dir=$(mktemp -dt)
trap "rm -rf ${dir}" EXIT
{{ .cmd.os.install }} gdebi-core
wget -O $dir/discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
{{ .cmd.sudo }} gdebi $dir/discord.deb
