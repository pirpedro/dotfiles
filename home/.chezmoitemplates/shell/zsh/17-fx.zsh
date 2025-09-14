# chezmoi:template:left-delimiter="{["
# chezmoi:template:right-delimiter="]}"

# ---------------- Git ----------------
fx_git_branch() {
  command_exists git || { echo "git not found"; return 1; }
  local target br
  target="$(
    git for-each-ref --format='%(refname:short) | %(committerdate:short) | %(subject)' refs/heads refs/remotes \
    | awk -F' \\| ' '{printf "%-40s | %-10s | %s\n",$1,$2,$3}' \
    | sort -u \
    | fzf --header="Checkout branch" \
          --with-nth=1,2,3 \
          --preview='git log --color=always --decorate --oneline -n 30 -- {1}'
  )" || return
  br="${target%% *}"
  if [[ "$br" == */* && ! -f ".git/refs/heads/${br##*/}" ]]; then
    git checkout -t "$br"
  else
    git checkout "${br##*/}"
  fi
}

fx_git_hash() {
  command_exists git || { echo "git not found"; return 1; }
  local pick
  pick="$(git log --decorate --date=relative --pretty=format:'%h | %ad | %s %d | %an' \
        | fzf --header="Checkout commit (detached)" --preview='git show --color=always {1}')" || return
  git checkout "${pick%% *}"
}

fx_git_file() {
  command_exists git || { echo "git not found"; return 1; }
  local file
  file="$(git ls-files \
        | fzf --header="Open tracked file" \
              --preview='bat --style=numbers --color=always --line-range=:300 {} 2>/dev/null || sed -n "1,200p" {}')" || return
  ${EDITOR:-vim} "$file"
}

fx_git_stash() {
  command_exists git || { echo "git not found"; return 1; }
  local s
  s="$(git stash list | fzf --header="Apply stash" --preview='git stash show -p --color=always {1}')" || return
  git stash apply "$(echo "$s" | awk -F: '{print $1}')"
}

# ---------------- Docker ----------------
fx_docker_ps() {
  command_exists docker || { echo "docker not found"; return 1; }
  local row cid action
  row="$(docker ps --format '{{.ID}} | {{.Names}} | {{.Status}} | {{.Image}}' \
      | fzf --header="Choose a running container" \
            --preview='docker inspect --format "{{json .State }}" {1} | jq . 2>/dev/null || docker logs --tail=80 --since=10m {1}')" || return
  cid="$(echo "$row" | awk -F' | ' '{print $1}')"
  action="$(printf "logs\nshell\nexec bash\nkill\nrestart" | fzf --header="Action for $cid")" || return
  case "$action" in
    logs)    docker logs -f "$cid" ;;
    shell)   docker exec -it "$cid" sh ;;
    "exec bash") docker exec -it "$cid" bash ;;
    kill)    docker kill "$cid" ;;
    restart) docker restart "$cid" ;;
  esac
}

fx_docker_all() {
  command_exists docker || { echo "docker not found"; return 1; }
  local row cid action
  row="$(docker ps -a --format '{{.ID}} | {{.Names}} | {{.Status}} | {{.Image}}' \
      | fzf --header="Choose any container" \
            --preview='docker inspect --format "{{json .State }}" {1} | jq . 2>/dev/null')" || return
  cid="$(echo "$row" | awk -F' | ' '{print $1}')"
  action="$(printf "start\nattach\nrm" | fzf --header="Action for $cid")" || return
  case "$action" in
    start)  docker start "$cid" ;;
    attach) docker attach "$cid" ;;
    rm)     docker rm "$cid" ;;
  esac
}

fx_docker_img() {
  command_exists docker || { echo "docker not found"; return 1; }
  local row img action
  row="$(docker images --format '{{.Repository}}:{{.Tag}} | {{.ID}} | {{.Size}}' \
      | fzf --header="Choose an image" \
            --preview='docker inspect --format "{{json .RepoTags }}" {1} | jq . 2>/dev/null')" || return
  img="$(echo "$row" | awk -F' | ' '{print $1}')"
  action="$(printf "run\nrmi" | fzf --header="Action for $img")" || return
  case "$action" in
    run) docker run -it --rm "$img" sh ;;
    rmi) docker rmi "$img" ;;
  esac
}

# ---------------- History (Bash & Zsh) ----------------
fx_hist() {
  # Cross-shell history picker. Executes the selected command.
  local selected
  if [ -n "$ZSH_VERSION" ]; then
    # zsh: fc -rl 1 prints most-recent-first with numbers
    selected=$(fc -rl 1 | fzf --tac --no-sort --header="History (Enter=run)" --preview='echo {}') || return
    selected="${selected#* }"          # strip leading number
    print -s -- "$selected"            # append back to history (zsh)
  else
    # bash: use `history`, strip leading number and spaces
    selected=$(history | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//' \
              | fzf --tac --no-sort --header="History (Enter=run)" --preview='echo {}') || return
    history -s "$selected"             # append to history (bash)
  fi
  eval "$selected"
}

# ---------------- Processes ----------------
fx_kill() {
  local row pid
  row="$(ps -eo pid,ppid,comm,%cpu,%mem --sort=-%cpu \
      | sed 1d \
      | awk '{printf "%-8s %-8s %-30s %5s%% %5s%%\n",$1,$2,$3,$4,$5}' \
      | fzf --header="Pick a process to kill" --preview='ps -p {1} -o pid,ppid,etime,cmd | sed 1d')" || return
  pid="$(echo "$row" | awk '{print $1}')"
  kill -9 "$pid"
}

# ---------------- Navigation ----------------
fx_z() {
  command_exists zoxide || { echo "zoxide not found (optional)"; return 1; }
  local dir
  dir="$(zoxide query -l | fzf --header="Jump to directory" --preview='ls -la --color=always {} | head -n 200')" || return
  cd "$dir" || return
}

fx_mark() {
  if ! command_exists jump; then
    echo "fzf-marks (jump) not found (optional)"
    return 1
  fi
  local dest
  dest="$(jump -s | fzf --header="fzf-marks" --preview='ls -la --color=always {} | head -n 200')" || return
  cd "$dest" || return
}

# ---------------- Dispatcher ----------------
fx() {
  local cmd="${1:-help}"
  case "$cmd" in
    br|branch)    fx_git_branch ;;
    hash)         fx_git_hash ;;
    file|open)    fx_git_file ;;
    stash)        fx_git_stash ;;
    dps)          fx_docker_ps ;;
    dall)         fx_docker_all ;;
    img)          fx_docker_img ;;
    hist|history) fx_hist ;;
    kill)         fx_kill ;;
    z|jump)       fx_z ;;
    mark|bm)      fx_mark ;;
    help|--help|-h)
      cat <<'EOF'
fx — fuzzy command palette
Usage: fx <subcommand>

Git:     branch|br, hash, file|open, stash
Docker:  dps, dall, img
System:  hist|history, kill
Nav:     z|jump, mark|bm

Tip: alias x='fx' for an even shorter name.
EOF
      ;;
    *) echo "Unknown subcommand: $cmd (try: fx help)"; return 1 ;;
  esac
}

# ---------------- Completion (Zsh & Bash) ----------------
if [ -n "$ZSH_VERSION" ]; then
  _fx() {
    local -a subs
    subs=(
      'branch:Checkout branch' 'br:Checkout branch (short)'
      'hash:Checkout commit' 'file:Open tracked file' 'open:Open tracked file'
      'stash:Apply a stash' 'dps:Running containers' 'dall:All containers'
      'img:Images actions' 'hist:Fuzzy history' 'history:Fuzzy history'
      'kill:Pick a process' 'z:Jump via zoxide' 'jump:Jump via zoxide'
      'mark:Jump via fzf-marks' 'bm:Jump via fzf-marks' 'help:Show help'
    )
    _describe -t subcommands 'fx subcommands' subs
  }

  compdef _fx fx
elif [ -n "$BASH_VERSION" ]; then
  _fxbash_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local subs="branch br hash file open stash dps dall img hist history kill z jump mark bm help"
    COMPREPLY=($(compgen -W "$subs" -- "$cur"))
  }
  complete -F _fxbash_complete fx
fi

# Optional tiny alias:
# alias x='fx'
# =========================================================
