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

---

- [Design Goals ⚽](#design-goals-)
- [Installation Guide ⚙️](#installation-guide-️)
  - [One line](#one-line)
  - [Manual](#manual)
- [Supported Systems](#supported-systems)
- [Supported Terminal Applications](#supported-terminal-applications)
  - [Shell Configuration](#shell-configuration)
  - [File Navigation and Search](#file-navigation-and-search)
  - [Text Manipulation](#text-manipulation)
  - [Multimedia](#multimedia)
  - [Networking](#networking)
  - [Http Tools](#http-tools)
  - [Package managers](#package-managers)
  - [Version Control](#version-control)
- [- git-extras GIT utilities, repo summary, repl, changelog population, author commit percentages and more](#--git-extras-git-utilities-repo-summary-repl-changelog-population-author-commit-percentages-and-more)
- [Supported Graphical Applications](#supported-graphical-applications)
  - [Terminals](#terminals)
  - [Universal apps 💾 <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>](#universal-apps--supsubb-titlelinuxbb-titlemacosbsubsup)
- [Gui apps](#gui-apps)



## Design Goals ⚽

- keep your configuration, hotkeys and shortcuts synced throught differents OS.
- Nice way to customize your dotfiles.
- Easy access to common paths.
- Make a prettier development environment.

<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Installation Guide ⚙️

### One line

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
---

### Manual

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

## Supported Systems
In the course of need multiple Operational Systems have been supported.
- Linux <sup><sub><b title="Linux">🐧</b></sub></sup>
  - Debian-Like (Debian, Ubuntu, Mint, Pop OS)
  - Fedora
- OSx <sup><sub><b title="macOS">🍎</b></sub></sup>
  - The support is not as completed as I want because I'm not using macbook anymore.
- Windows <sup><sub><b title="Windows">🪟</b></sub></sup>
  - It's possible to use chezmoi with Windows, but, come on, if you really are trying to keep track of your dotfiles go to a Unix environment or use WSL2.

## Supported Terminal Applications
### Shell Configuration

- [Bash](https://www.gnu.org/software/bash/): [`~/.bashrc`](./dot_bashrc)
- [Z shell](http://zsh.sourceforge.net/): [`~/.zshenv`](./dot_zshenv) _<sup>enhanced with [**prezto**](https://github.com/sorin-ionescu/prezto), [**Powerlevel10K**](https://github.com/romkatv/powerlevel10k), and others!</sup>_

---

### File Navigation and Search
- [fzf-marks](https://github.com/urbainvaes/fzf-marks) Plugin to manage bookmarks in zsh and bash. <sup><sub>mark \<mark> and ctrl-g shortcut </sub></sup>
- [fzf](https://github.com/junegunn/fzf) A command line fuzzy finder.
- [ranger](https://github.com/ranger/ranger) A VIM-inspired filemanager for the console: [`~/.config/ranger`](./home/private_dot_config/ranger)
- [ripgrep](https://github.com/BurntSushi/ripgrep) fast-search tool: [`~/.ripgreprc`](./dot_ripgreprc)

---

### Text Manipulation
- [vim](https://www.vim.org/) text editor: [`~/.vimrc`](./dot_vimrc) _<sup>enhanced with [**vim-plug**](https://github.com/junegunn/vim-plug)!</sup>_
- [bat](https://github.com/sharkdp/bat) cat clone with wings.
- [jq](https://github.com/stedolan/jq) command-line json processor.
- [pandoc](https://github.com/jgm/pandoc) universal markup converter.
- [lnav](http://lnav.org/) log file navigator.

---

### Multimedia
- [asciicinema](https://asciinema.org/) record and share your terminal sessions, the right way
- [imagemagick](https://imagemagick.org/index.php) create, edit, compose or convert digital images.
- [youtube-dl](https://github.com/rg3/youtube-dl) download videos from YouTube.com and other video sites
  
---

### Networking
- nmap
- [mitmproxy](https://github.com/mitmproxy/mitmproxy) An interactive TLS-capable intercepting HTTP proxy for penetration testers and software developers.

---

### Http Tools
- [httpie](https://github.com/jakubroztocil/httpie) Modern command line HTTP client – user-friendly curl alternative with intuitive UI, JSON support, syntax highlighting, wget-like downloads, extensions, etc.

---

### Package managers
- [apt](https://wiki.debian.org/Apt) <sub><sup><b title="Linux">🐧</b></sup></sub>
- [Homebrew](https://brew.sh/) <sub><sup><b title="macOS">🍎</b></sup></sub>: [`~/.Brewfile`](./dot_Brewfile)
- [Scoop](https://scoop.sh/) <sub><sup><b title="windows">🪟</b></sup></sub>

___

### Version Control
- [gh](https://github.com/cli/cli) Github's official command line tool.
- [git-extras](https://github.com/tj/git-extras) GIT utilities, repo summary, repl, changelog population, author commit percentages and more
---

## Supported Graphical Applications

### Terminals

- [kitty](https://sw.kovidgoyal.net/kitty/) <sub><sup><b title="Linux">🐧</b><b title="macOS">🍎</b></sup></sub>: [`~/.config/kitty/kitty.conf`](./private_dot_config/kitty/kitty.conf)
- [terminator](https://terminator-gtk3.readthedocs.io/en/latest/) <sub><sup><b title="Linux">🐧</b></sup></sub>: [`~/.config/terminator/config`](./private_dot_config/terminator/config)



### Universal apps 💾 <sup><sub><b title="Linux">🐧</b><b title="macOS">🍎</b></sub></sup>

- [chezmoi](https://www.chezmoi.io/) dotfiles manager: [`~/.chezmoi.yaml`](./.chezmoi.yaml.tmpl)
- [cURL](https://curl.haxx.se/) data transfer tool: [`~/.curlrc`](./dot_curlrc)
- [Git :octocat:](https://git-scm.com/) version-control system: [`~/.config/git/config`](./private_dot_config/git/config.tmpl)
- [GNU Nano 4.x+](https://www.nano-editor.org/) text editor: [`~/.nanorc`](./dot_nanorc) _<sup>enhanced with [**Improved Nano Syntax Highlighting Files**](https://github.com/scopatz/nanorc)!</sup>_
- [GNU Wget](https://www.gnu.org/software/wget/) HTTP/FTP file downloader: [`~/.wgetrc`](./dot_wgetrc)
- [OpenSSH](https://www.openssh.com/) secure networking utilities: [`~/.ssh/config`](./private_dot_ssh/config.tmpl)
- [psql](https://www.postgresql.org/docs/13/app-psql.html) terminal-based front-end to PostgreSQL: [`~/.psqlrc`](./dot_psqlrc)


<p align="right"><a href="#top" title="Back to top">🔝</a></p>

## Gui apps

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

> README inspired by [`renemarc/dotfiles`](https://github.com/renemarc/dotfiles).

---

<p align="center"><strong>Don't forget to <a href="#" title="star">⭐️</a> or <a href="#" title="fork">🔱</a> this repo! 😃<br/><sub>Assembled with <b title="love">❤️</b> in Rio de Janeiro.</sub></strong></p>

[badge-analytics]: https://img.shields.io/badge/repo%20analytics-public-informational?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTIxIDhDMTkuNSA4IDE4LjcgOS40IDE5LjEgMTAuNUwxNS41IDE0LjFDMTUuMiAxNCAxNC44IDE0IDE0LjUgMTQuMUwxMS45IDExLjVDMTIuMyAxMC40IDExLjUgOSAxMCA5QzguNiA5IDcuNyAxMC40IDguMSAxMS41TDMuNSAxNkMyLjQgMTUuNyAxIDE2LjUgMSAxOEMxIDE5LjEgMS45IDIwIDMgMjBDNC40IDIwIDUuMyAxOC42IDQuOSAxNy41TDkuNCAxMi45QzkuNyAxMyAxMC4xIDEzIDEwLjQgMTIuOUwxMyAxNS41QzEyLjcgMTYuNSAxMy41IDE4IDE1IDE4QzE2LjUgMTggMTcuMyAxNi42IDE2LjkgMTUuNUwyMC41IDExLjlDMjEuNiAxMi4yIDIzIDExLjQgMjMgMTBDMjMgOC45IDIyLjEgOCAyMSA4TTE1IDlMMTUuOSA2LjlMMTggNkwxNS45IDUuMUwxNSAzTDE0LjEgNS4xTDEyIDZMMTQuMSA2LjlMMTUgOU0zLjUgMTFMNCA5TDYgOC41TDQgOEwzLjUgNkwzIDhMMSA4LjVMMyA5TDMuNSAxMVoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+&maxAge=86400
[badge-codefactor]: https://img.shields.io/codefactor/grade/github/pirpedro/dotfiles?logo=codefactor&logoColor=white&cacheSeconds=300
[badge-license]: https://img.shields.io/github/license/renemarc/dotfiles.svg?logo=data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz48IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZD0iTTE3LjgsMjBDMTcuNCwyMS4yIDE2LjMsMjIgMTUsMjJINUMzLjMsMjIgMiwyMC43IDIsMTlWMThINUwxNC4yLDE4QzE0LjYsMTkuMiAxNS43LDIwIDE3LDIwSDE3LjhNMTksMkMyMC43LDIgMjIsMy4zIDIyLDVWNkgyMFY1QzIwLDQuNCAxOS42LDQgMTksNEMxOC40LDQgMTgsNC40IDE4LDVWMThIMTdDMTYuNCwxOCAxNiwxNy42IDE2LDE3VjE2SDVWNUM1LDMuMyA2LjMsMiA4LDJIMTlNOCw2VjhIMTVWNkg4TTgsMTBWMTJIMTRWMTBIOFoiIGZpbGw9IiNmZmZmZmYiIC8+PC9zdmc+Cg==&maxAge=86400
[badge-twitter]: https://img.shields.io/twitter/url/http/shields.io.svg?style=social&maxAge=86400
[link-analytics]: https://repo-analytics.github.io/pirpedro/dotfiles
[link-codefactor]: https://www.codefactor.io/repository/github/pirpedro/dotfiles/overview/main
[link-license]: LICENSE.txt
[link-twitter]: https://twitter.com/intent/tweet?text=Cross-platform%2C%20cross-shell%20%23dotfiles%20using%20%23chezmoi&url=https://github.com/pirpedro/dotfiles&via=pirpedro&hashtags=dotfiles,chezmoi
