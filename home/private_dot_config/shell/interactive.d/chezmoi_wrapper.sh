# Add a chezmoi "subcommand" in the shell
chezmoi() {
  # If the first arg is "install", intercept; otherwise call real chezmoi
  if [[ "${1:-}" == "install" ]]; then
    shift
    # Usage: chezmoi install <package> [--dry-run]
    local pkg="${1:-}"
    [[ -z "$pkg" ]] && { echo "Usage: chezmoi install <package> [--dry-run]"; return 2; }
    shift || true

    local src_dir
    src_dir="$(command chezmoi source-path)" || return 1
    local tmpl="${src_dir}/.chezmoiscripts/install/${pkg}.sh.tmpl"

    [[ -f "$tmpl" ]] || { echo "Template not found: $tmpl"; return 1; }

    if [[ "${1:-}" == "--dry-run" ]]; then
      echo "# ---- RENDERED SCRIPT (${pkg}) ----"
      command chezmoi execute-template < "$tmpl"
    else
      command chezmoi execute-template < "$tmpl" | bash
    fi
  else
    # Delegate to the real chezmoi binary
    command chezmoi "$@"
  fi
}
