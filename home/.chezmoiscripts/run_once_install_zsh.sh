#!/bin/sh

DEBIAN_FRONTEND=noninteractive sudo apt -qq -y install zsh
sudo chsh -s $(which zsh) $(whoami)