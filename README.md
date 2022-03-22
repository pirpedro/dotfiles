<h1 align="center">
    <a name="top" title="dotfiles">~/.&nbsp;📂</a><br/>Pedro Rodrigues cross-platform, cross-shell dotfiles<br/> <sup><sub>powered by  <a href="https://www.chezmoi.io/">chezmoi</a> 🏠</sub></sup>
</h1>

[![CodeFactor][badge-codefactor]][link-codefactor]
[![License][badge-license]][link-license]
[![Repo analytics][badge-analytics]][link-analytics]
[![Tweet][badge-twitter]][link-twitter]

<div align="center">
    <p><strong>Be sure to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo if you find it useful! 😃</strong></p>
</div>

- [1. Goals ⚽](#1-goals-)
- [2. Installation Guide ⚙️](#2-installation-guide-️)
  - [2.1. One line](#21-one-line)
  - [2.2. Manual](#22-manual)
- [3. Supported Tools 🧰](#3-supported-tools-)
  - [3.1. Shells 🐚](#31-shells-)
  - [3.2. Terminals 💻](#32-terminals-)
  - [3.3. Package managers 📦](#33-package-managers-)
  - [3.4. Universal apps 💾 <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>](#34-universal-apps--supsubb-titlelinuxbb-titlemacosbsubsup)
  - [3.5. Gui apps 🖼️ <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>](#35-gui-apps-️-supsubb-titlelinuxbb-titlemacosbsubsup)

## 1. Goals ⚽

- keep your configuration, hotkeys and shortcuts synced throught differents OS.
- Nice way to customize your dotfiles.
- Easy access to common paths.
- Make a prettier development environment.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## 2. Installation Guide ⚙️

### 2.1. One line

If you don't have, please install `curl` or `wget`.

```bash
sudo apt install curl
```

After that download the installation script and see the magic works.

```bash
curl -sfL https://raw.githubusercontent.com/pirpedro/dotfiles/main/install.sh | sh
```

It is possible to pass any kind of `chezmoi init` flags to the installation process.
Like, if you want to purge any trace of the installation files

```bash
curl -sfL https://raw.githubusercontent.com/pirpedro/dotfiles/main/install.sh | sh -s -- -p -P
```

### 2.2. Manual

Install chezmoi

```bash
sh -c "$(curl -fsSL https://chezmoi.io/get)" -- -b "$HOME/.local/bin"
```

Clone the repository

```bash
git clone git@github.com:pirpedro/dotfiles.git "$HOME/.local/share/chezmoi"
```

And execute `chezmoi` with `-a` flag to auto apply the changes to your home dir.

```bash
chezmoi init -a
```

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## 3. Supported Tools 🧰

### 3.1. Shells 🐚

- [Bash](https://www.gnu.org/software/bash/) <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>: [`~/.bashrc`](./dot_bashrc)
- [Z shell](http://zsh.sourceforge.net/) <sub><sup><b title="Linux">🐧</b></sup></sub><b title="macOS">🍎</b>: [`~/.zshenv`](./dot_zshenv) _<sup>enhanced with [**prezto**](https://github.com/sorin-ionescu/prezto), [**Powerlevel10K**](https://github.com/romkatv/powerlevel10k), and others!</sup>_

### 3.2. Terminals 💻

- [kitty](https://sw.kovidgoyal.net/kitty/) <sub><sup><b title="Linux">🐧</b><b title="macOS">🍎</b></sup></sub>: [`~/.config/kitty/kitty.conf`](./private_dot_config/kitty/kitty.conf)
- [terminator](https://terminator-gtk3.readthedocs.io/en/latest/) <sub><sup><b title="Linux">🐧</b></sup></sub>: [`~/.config/terminator/config`](./private_dot_config/terminator/config)

### 3.3. Package managers 📦

- [apt](https://wiki.debian.org/Apt) <sub><sup><b title="Linux">🐧</b></sup></sub>
- [Homebrew](https://brew.sh/) <sub><sup><b title="macOS">🍎</b></sup></sub>: [`~/.Brewfile`](./dot_Brewfile)
- [Scoop](https://scoop.sh/) <sub><sup><b title="windows">🪟</b></sup></sub>

### 3.4. Universal apps 💾 <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>

- [chezmoi](https://www.chezmoi.io/) dotfiles manager: [`~/.chezmoi.yaml`](./.chezmoi.yaml.tmpl)
- [cURL](https://curl.haxx.se/) data transfer tool: [`~/.curlrc`](./dot_curlrc)
- [Git :octocat:](https://git-scm.com/) version-control system: [`~/.config/git/config`](./private_dot_config/git/config.tmpl)
- [GNU Nano 4.x+](https://www.nano-editor.org/) text editor: [`~/.nanorc`](./dot_nanorc) _<sup>enhanced with [**Improved Nano Syntax Highlighting Files**](https://github.com/scopatz/nanorc)!</sup>_
- [GNU Wget](https://www.gnu.org/software/wget/) HTTP/FTP file downloader: [`~/.wgetrc`](./dot_wgetrc)
- [OpenSSH](https://www.openssh.com/) secure networking utilities: [`~/.ssh/config`](./private_dot_ssh/config.tmpl)
- [psql](https://www.postgresql.org/docs/13/app-psql.html) terminal-based front-end to PostgreSQL: [`~/.psqlrc`](./dot_psqlrc)
- [Ripgrep](https://github.com/BurntSushi/ripgrep) fast-search tool: [`~/.ripgreprc`](./dot_ripgreprc)
- [Vim](https://www.vim.org/) text editor: [`~/.vimrc`](./dot_vimrc)

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

### 3.5. Gui apps 🖼️ <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>

- [Ansible](https://www.ansible.com/) IT automation.
- [Apache](https://httpd.apache.org/) web server.
- [Balena Etcher](https://www.balena.io/etcher/) utility to write image files onto storage medias.
- [Bitwarden](https://bitwarden.com/) password management service.
- [Calibre](https://calibre-ebook.com/) e-book manager.
- [DBeaver](https://dbeaver.io/) SQL client.
- [Delta](https://github.com/dandavison/delta) Syntax highlighting pager for git and diff.
- [Docker](https://www.docker.com/) Container provider.
- [Google Chrome](https://www.google.com/chrome/) web browser.
- [NeoVim](https://neovim.io/) vim alternative: [`~/.config/nvim/init.vim`](./private_dot_config/nvim/init.vim.tmpl)
- [sushi:GNOME](https://gitlab.gnome.org/GNOME/sushi) file previewer.
- [Ulauncher](https://ulauncher.io/) launcher fro linux.
- [VS Code](https://code.visualstudio.com/) code editor.


<p align="right"><a href="#top" title="Back to top">🔝</a></p>

README inspired by [`renemarc/dotfiles`](https://github.com/renemarc/dotfiles).

<p align="center"><strong>Don't forget to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo! 😃<br/><sub>Assembled with <b title="love">❤️</b> in Rio de Janeiro.</sub></strong></p>

[badge-analytics]: https://img.shields.io/badge/repo%20analytics-public-informational?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDhDMTkuNSA4IDE4LjcgOS40IDE5LjEgMTAuNUwxNS41IDE0LjFDMTUuMiAxNCAxNC44IDE0IDE0LjUgMTQuMUwxMS45IDExLjVDMTIuMyAxMC40IDExLjUgOSAxMCA5QzguNiA5IDcuNyAxMC40IDguMSAxMS41TDMuNSAxNkMyLjQgMTUuNyAxIDE2LjUgMSAxOEMxIDE5LjEgMS45IDIwIDMgMjBDNC40IDIwIDUuMyAxOC42IDQuOSAxNy41TDkuNCAxMi45QzkuNyAxMyAxMC4xIDEzIDEwLjQgMTIuOUwxMyAxNS41QzEyLjcgMTYuNSAxMy41IDE4IDE1IDE4QzE2LjUgMTggMTcuMyAxNi42IDE2LjkgMTUuNUwyMC41IDExLjlDMjEuNiAxMi4yIDIzIDExLjQgMjMgMTBDMjMgOC45IDIyLjEgOCAyMSA4TTE1IDlMMTUuOSA2LjlMMTggNkwxNS45IDUuMUwxNSAzTDE0LjEgNS4xTDEyIDZMMTQuMSA2LjlMMTUgOU0zLjUgMTFMNCA5TDYgOC41TDQgOEwzLjUgNkwzIDhMMSA4LjVMMyA5TDMuNSAxMVoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+&maxAge=86400
[badge-codefactor]: https://img.shields.io/codefactor/grade/github/pirpedro/dotfiles?logo=codefactor&logoColor=white&cacheSeconds=300
[badge-license]: https://img.shields.io/github/license/renemarc/dotfiles.svg?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3LjgsMjBDMTcuNCwyMS4yIDE2LjMsMjIgMTUsMjJINUMzLjMsMjIgMiwyMC43IDIsMTlWMThINUwxNC4yLDE4QzE0LjYsMTkuMiAxNS43LDIwIDE3LDIwSDE3LjhNMTksMkMyMC43LDIgMjIsMy4zIDIyLDVWNkgyMFY1QzIwLDQuNCAxOS42LDQgMTksNEMxOC40LDQgMTgsNC40IDE4LDVWMThIMTdDMTYuNCwxOCAxNiwxNy42IDE2LDE3VjE2SDVWNUM1LDMuMyA2LjMsMiA4LDJIMTlNOCw2VjhIMTVWNkg4TTgsMTBWMTJIMTRWMTBIOFoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+Cg==&maxAge=86400
[badge-twitter]: https://img.shields.io/twitter/url/http/shields.io.svg?style=social&maxAge=86400
[link-analytics]: https://repo-analytics.github.io/pirpedro/dotfiles
[link-codefactor]: https://www.codefactor.io/repository/github/pirpedro/dotfiles/overview/main
[link-license]: LICENSE.txt
[link-twitter]: https://twitter.com/intent/tweet?text=Cross-platform%2C%20cross-shell%20%23dotfiles%20using%20%23chezmoi&url=https://github.com/pirpedro/dotfiles&via=pirpedro&hashtags=dotfiles,chezmoi