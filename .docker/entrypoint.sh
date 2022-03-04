#!/bin/sh

set -e

locale-gen en_US en_US.UTF-8 pt_BR.UTF-8
dpkg-reconfigure locales

# chezmoi init
# chezmoi apply
while sleep 1000; do :; done
