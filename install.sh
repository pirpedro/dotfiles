#!/bin/sh
# install.sh — Bootstrap chezmoi + initialize your dotfiles (local or remote)
# POSIX-compliant (sh), safe on Linux/macOS.

# --- Safety -------------------------------------------------------------------
# -e: exit on first error; -u: error on unset vars
[ "${DEBUG:-}" = "1" ] && set -x
set -eu

# --- Defaults (overridable via env) -------------------------------------------
REPO_USER="${REPO_USER:-pirpedro}"        # used if DOTFILES_URL not provided
REPO_NAME="${REPO_NAME:-dotfiles}"        # used if DOTFILES_URL not provided
INSTALL_BIN_DIR="${INSTALL_BIN_DIR:-$HOME/.local/bin}"

# Optional overrides:
# - DOTFILES_URL="https://github.com/user/dotfiles.git"  (forces remote)
# - CHEZMOI_SOURCE="$HOME/path/to/dotfiles"              (forces local)
# - DEFAULT_BRANCH="main"                              (only if set: adds --branch)

say() { printf '%s\n' "$*"; }
err() { printf 'ERRO: %s\n' "$*" >&2; }

ensure_chezmoi() {
  # If chezmoi is already available, use it.
  if command -v chezmoi >/dev/null 2>&1; then
    CHZ="$(command -v chezmoi)"
    return
  fi

  # Try platform-native install first (macOS Homebrew), then official script.
  if [ "$(uname -s)" = "Darwin" ] && command -v brew >/dev/null 2>&1; then
    say "Installing chezmoi via Homebrew..."
    brew install chezmoi >/dev/null
  else
    say "Installing chezmoi into ${INSTALL_BIN_DIR} ..."
    mkdir -p "$INSTALL_BIN_DIR"
    if command -v curl >/dev/null 2>&1; then
      sh -c "$(curl -fsSL get.chezmoi.io)" -- -b "$INSTALL_BIN_DIR"
    elif command -v wget >/dev/null 2>&1; then
      sh -c "$(wget -qO- get.chezmoi.io)" -- -b "$INSTALL_BIN_DIR"
    else
      err "curl or wget is required to install chezmoi."
      exit 1
    fi
  fi

  # Resolve chezmoi binary path even if ~/.local/bin is not on PATH.
  if [ -x "${INSTALL_BIN_DIR}/chezmoi" ]; then
    CHZ="${INSTALL_BIN_DIR}/chezmoi"
  elif command -v chezmoi >/dev/null 2>&1; then
    CHZ="$(command -v chezmoi)"
  else
    err "chezmoi installed but not found on PATH. Add ${INSTALL_BIN_DIR} to PATH and retry."
    exit 1
  fi
}

detect_mode() {
  # Priority 1: explicit local source via CHEZMOI_SOURCE
  if [ -n "${CHEZMOI_SOURCE:-}" ]; then
    if [ -d "$CHEZMOI_SOURCE" ]; then
      MODE="local"
      SRC_DIR="$CHEZMOI_SOURCE"
      return
    else
      err "CHEZMOI_SOURCE is set but not a directory: $CHEZMOI_SOURCE"
      exit 1
    fi
  fi

  # Priority 2: explicit remote via DOTFILES_URL
  if [ -n "${DOTFILES_URL:-}" ]; then
    MODE="remote"
    REMOTE_URL="$DOTFILES_URL"
    return
  fi

  # Priority 3: infer from how the script was launched
  # If $0 contains a slash (/ or */*), we assume it's a local file path.
  case "$0" in
    /*|*/*)
      # Resolve the script directory
      # shellcheck disable=SC3000
      if [ -r "$0" ]; then
        SRC_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
        MODE="local"
        return
      fi
      ;;
  esac

  # Fallback: remote using GitHub user/repo
  MODE="remote"
  REMOTE_URL="https://github.com/${REPO_USER}/${REPO_NAME}.git"
}

# Build the argv for "chezmoi init ..."
# Pass all user-provided flags after our defaults, so the user can override.
build_cmdline() {
  # Preserve user flags passed to this function
  user_flags="$*"
  # Start with 'init' and apply by default
  set -- init --apply

   # Only add --branch if DEFAULT_BRANCH is set (non-empty)
  if [ -n "${DEFAULT_BRANCH:-}" ]; then
    set -- "$@" --branch "$DEFAULT_BRANCH"
  fi

  if [ "$MODE" = "local" ]; then
    # Use local source directory
    set -- "$@" --source "$SRC_DIR"
  else
    # Use remote repository URL (explicit DOTFILES_URL or derived from user/repo)
    set -- "$@" "$REMOTE_URL"
  fi

  # acrescenta as flags passadas pelo usuário ao install.sh
  # (ex.: -p -P, --branch main, etc.)
  # shellcheck disable=SC2068
  set -- "$@" $user_flags
  INIT_ARGV="$*"
}

main() {
  ensure_chezmoi
  detect_mode
  build_cmdline "$@"
  say "Running: ${CHZ} ${INIT_ARGV}"
  exec "${CHZ}" ${INIT_ARGV}
}

main "$@"
