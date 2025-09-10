#   --------------------------------------------------------------------------
#   FILES & NAVIGATION
#   --------------------------------------------------------------------------

#   safer core alias
#   ------------------------------------------------------------
alias cp='cp -iv'                         # Preferred 'cp' implementation
alias mv='mv -iv'                         # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                   # Preferred 'mkdir' implementation
alias less='less -FSRXc'                  # Preferred 'less' implementation
alias c='clear'                           # c:            Clear terminal display

#   cd helpers
#   ------------------------------------------------------------
alias cd..='cd ../'                       # Go back 1 directory level (for fast typers)
alias ..='cd ../'                         # Go back 1 directory level
alias ...='cd ../../'                     # Go back 2 directory levels
alias .3='cd ../../../'                   # Go back 3 directory levels
alias .4='cd ../../../../'                # Go back 4 directory levels
alias .5='cd ../../../../../'             # Go back 5 directory levels
alias .6='cd ../../../../../../'          # Go back 6 directory levels
alias ~="cd ~"                            # ~:            Go Home

#   path printer
#   ------------------------------------------------------------
alias path='echo -e ${PATH//:/\\n}'

#   ls/eza
#   ------------------------------------------------------------
unalias ls 2>/dev/null                    # unalias ls in behalf of $HOME/.local/bin/ls command

if command_exists eza; then
  alias ls='eza --group-directories-first --icons --classify --hyperlink --color-scale'
  alias ll='eza -la --header --group --git --git-ignore \
                --time=modified --time-style=relative \
                --group-directories-first --icons --classify --hyperlink --color-scale -h'
  # Árvore compacta (tipo lsd --tree)
  alias lt='eza --tree --level=2 --group-directories-first --icons --classify --git'
  # Atalhos por critério (como lsd --sort)
  alias lS='eza -l -h --sort=size   --group-directories-first --icons --classify'
  alias lT='eza -l -h --sort=modified --group-directories-first --icons --classify'
  alias lX='eza -l -h --sort=extension --group-directories-first --icons --classify'
else
  alias ls='ls -F'
  alias ll='ls -FGlAhp'                  # Preferred 'ls' implementation
fi
alias la='ls -A'
alias l='ls -CF'

#   Wrappers with progress
#   ---------------------------------------------------------
if command_exists progress; then
  function cp() { /usr/bin/env cp "$@" & progress -mp $!; }
  function mv() { /usr/bin/env mv "$@" & progress -mp $!; }
fi

#   zipf: Zip folder
#   ---------------------------------------------------------
zipf() { zip -r "$1".zip "$1"; }       # zipf:         To create a ZIP archive of a folder

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract() {
  [ -f "$1" ] || { echo "'$1' is not a file"; return 1; }
  case "$1" in
    *.tar.bz2) tar xjf "$1" ;;
    *.tar.gz)  tar xzf "$1" ;;
    *.bz2)     bunzip2 "$1" ;;
    *.rar)     unrar e "$1" ;;
    *.gz)      gunzip "$1" ;;
    *.tar)     tar xf "$1" ;;
    *.tbz2)    tar xjf "$1" ;;
    *.tgz)     tar xzf "$1" ;;
    *.zip)     unzip "$1" ;;
    *.Z)       uncompress "$1" ;;
    *.7z)      7z x "$1" ;;
    *)         echo "can't extract '$1'"; return 2 ;;
  esac
}

#   mkcd:  Make directory and cd into it (may be useful in interactive and scripts)
#   ---------------------------------------------------------
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }

#   mkfixedsize:  Portable fixed-size file creators (make1/5/10mb)
#   ---------------------------------------------------------
mkfixedsize() {
  # Usage: mkfixedsize <MB> <OUT>
  mb="$1"; out="$2"; [ -n "$mb" ] && [ -n "$out" ] || { echo "usage: mkfixedsize <MB> <FILE>" >&2; return 2; }
  bytes=$(( mb * 1048576 ))
  if command -v mkfile >/dev/null 2>&1; then mkfile "${mb}m" -- "$out"
  elif command -v fallocate >/dev/null 2>&1; then fallocate -l "$bytes" -- "$out"
  elif command -v truncate  >/dev/null 2>&1; then truncate  -s "$bytes" -- "$out"
  else dd if=/dev/zero of="$out" bs=1M count="$mb" status=none 2>/dev/null || dd if=/dev/zero of="$out" bs=1048576 count="$mb"; fi
}
alias make1mb='mkfixedsize 1  ./1MB.dat'
alias make5mb='mkfixedsize 5  ./5MB.dat'
alias make10mb='mkfixedsize 10 ./10MB.dat'

#   --------------------------------------------------------------------------
#   SEARCH & VIEWING
#   --------------------------------------------------------------------------

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.            Example: mans mplayer codec
#   --------------------------------------------------------------------
mans() {
  man -- "$1" | grep -iC2 --color=always -- "$2" | less
}

#   bat integrations
#   ------------------------------------------------------------
if command_exists {{ .cmd.bat }}; then
  alias cat='{{ .cmd.bat }} --paging=never'
  tailf() { tail -f -- "$1" | {{ .cmd.bat }} --paging=never -l; }
  ff() { /usr/bin/find . -name "$@" -exec {{ .cmd.bat }} {} +; }     # ff:       Find file under the current directory
  ffs() { /usr/bin/find . -name "$@"'*' -exec {{ .cmd.bat }} {} +; } # ffs:      Find file whose name starts with a given string
  ffe() { /usr/bin/find . -name '*'"$@" -exec {{ .cmd.bat }} {} +; } # ffe:      Find file whose name ends with a given
  batfind() { /usr/bin/find "$@" -exec {{ .cmd.bat }} {} +; }
  batfd() { fd "$@" -X {{ .cmd.bat }}; }
  batdiff() { git diff --name-only --diff-filter=d | xargs {{ .cmd.bat }} --diff; }
fi

#   qfind:    Quickly search for file
#   ------------------------------------------------------------
qfind(){ find . -name "$1"; }

#   Prefer fd for “find” in interactive sessions
#   ------------------------------------------------------------
command_exists fd  && alias find='fd'

#   showa: list current aliases filtered by a substring (default) or regex (-r)
#   Usage:
#     showa             # list all aliases
#     showa git         # substring, case-insensitive
#     showa -r 'g(ra|re)p'  # extended regex
#   ------------------------------------------------------------
showa() {
  # pick mode
  grepargs="-F"                # fixed substring by default
  if [ "${1-}" = "-r" ]; then
    grepargs="-E"; shift       # extended regex
  fi
  pat="${*:-.}"                # pattern or "." (everything)

  # list aliases once, normalized
  __showa_list() {
    alias | sed -E 's/^alias[[:space:]]+//' | LC_ALL=C sort
  }

  # first: check if there are matches; if none, don't open less
  if __showa_list | LC_ALL=C grep -i $grepargs -q -- "$pat"; then
    # now print with color, strip blank lines just in case
    __showa_list \
      | LC_ALL=C grep -i $grepargs --color=always -- "$pat" \
      | grep -v '^[[:space:]]*$' \
      | {
          if [ -t 1 ] && command -v less >/dev/null 2>&1; then
            less -FSRXc
          else
            cat
          fi
        }
  else
    printf 'No aliases match: %s\n' "$pat" >&2
    return 1
  fi
}



#   --------------------------------------------------------------------------
#   PROCESS & SYSTEM INFO
#   --------------------------------------------------------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid() { lsof -t -c "$@"; }


#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command; }


ii() {
  RED="$(tput setaf 1 2>/dev/null || true)"
  NC="$(tput sgr0 2>/dev/null || true)"

  echo
  echo "${RED}Host:${NC} $(hostname)"
  echo "${RED}User:${NC} $USER"
  echo "${RED}OS:${NC} $(uname -srmo)"
  echo "${RED}Date:${NC} $(date)"
  echo "${RED}Uptime:${NC} $(uptime -p 2>/dev/null || uptime)"

  echo
  echo "${RED}Logged users:${NC}"
  who

  echo
  echo "${RED}Network:${NC}"
  unameOut="$(uname -s)"
  case "$unameOut" in
    Darwin)
      scselect 2>/dev/null || echo "scselect not available"
      echo "Public IP: $(curl -s ifconfig.me || echo N/A)"
      scutil --dns | grep 'nameserver\[[0-9]*\]' || true
      ;;
    Linux)
      ip -4 addr show | awk '/inet / {print $2, "on", $NF}'
      echo "Public IP: $(curl -s ifconfig.me || echo N/A)"
      grep "nameserver" /etc/resolv.conf | awk '{print $2}'
      ;;
    *)
      echo "OS $unameOut not supported in ii()"
      ;;
  esac
}

#   --------------------------------------------------------------------------
#   NETWORKING
#   --------------------------------------------------------------------------

alias myip='curl -s http://whatismyip.akamai.com/' # myip:         Public facing IP Address
alias netCons='lsof -i'                            # netCons:      Show all open TCP/IP sockets
alias openPorts='sudo lsof -i | grep LISTEN'       # openPorts:    All listening connections


#   --------------------------------------------------------------------------
#   SYSTEMS OPS
#   --------------------------------------------------------------------------

alias u='{{ .cmd.os.upgrade }}'
alias updt='{{ .cmd.os.upgrade }}'

#   --------------------------------------------------------------------------
#   WEB DEVELOPMENT
#   --------------------------------------------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'    # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'         # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'            # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log" # Apachelogs:   Shows apache error logs
httpHeaders() { /usr/bin/curl -I -L $@; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
httpDebug() { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n"; }

#   --------------------------------------------------------------------------
#   MISC
#   --------------------------------------------------------------------------

#   kitty
#   ------------------------------------------------------------
{{ if not .is.headless -}}
  command_exists kitty && alias ssh='kitty +kitten ssh'
{{ end -}}

alias gist='gist -c'
alias numFiles='echo $(ls -1 | wc -l)' # numFiles:     Count of non-hidden files in current dir
