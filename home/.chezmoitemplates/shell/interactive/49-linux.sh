# Carregar apenas em Linux
[ "$(uname -s)" = "Linux" ] || return 0

alias f='xdg-open .'                       # f:            Opens current directory in default File Manager
trash() { command gvfs-trash "$@"; }       # trash:        Moves a file to the trash
ql() { sushi "$*" >&/dev/null; }           # ql:           Opens any file in Sushi Quicklook Preview
alias pbcopy='xclip -selection clipboard'  # pbcopy:       Emulate MacOS copy function in linux
alias pbpaste='xclip -selection clipboard -o' # pbpaste:      Emulate MacOS paste function in linux

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#   ------------------------------------------
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# mem/cpu “hog” alternativas
alias mem_hogs='ps aux --sort=-rss | head -n 15'
alias cpu_hogs='ps aux --sort=-%cpu | head -n 15'
