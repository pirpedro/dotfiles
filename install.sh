#!/bin/sh

set -e # -e: exit on error

GITHUB_REPO=pirpedro

if [ ! "$(command -v chezmoi)" ]; then
  bin_dir="$HOME/.local/bin"
  chezmoi="$bin_dir/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsSL https://chezmoi.io/get)" -- -b "$bin_dir"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- https://chezmoi.io/get)" -- -b "$bin_dir"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
  chezmoi=chezmoi
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"
# check if the script is running from stdin or from a file.
# if stdin is usage, try to downlaad source files form my pirpedro/dotfiles repository
if [ $script_dir != "$(dirname $(which sh))" ]; then
  cmd_options="-a --source ${script_dir}"
else
  cmd_options="$GITHUB_REPO -a"
fi

if [ -n "$*" ]; then
  cmd_options="$cmd_options $*"
fi

# exec: replace current process with chezmoi init
exec "${chezmoi}" init ${cmd_options}
